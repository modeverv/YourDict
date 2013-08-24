class TranslateWorker
  include Sidekiq::Worker
  
  def perform string,userid
    # 翻訳エンジン
    trans = Translation.new
p string
    # stringを split
    words = string.chomp.split(' ').map{|w| w.downcase.chomp }
p words

    # userの単語
    user = User.find(userid)
    userwords = user.word

    # もしなければ翻訳APIに投げる
    # slow code
    flg = false
    words.each do |w|
      puts w
      flg = false
      userwords.each do |uword|
        if uword.word == w
          # 既にある言葉
          uword.count += 1
          uword.save!
          flg = true
        end
      end
      next if flg
      Word.create!(
                   :user_id => user.id,
                   :word => w,
                   :translate => trans.trans(w),
                   :count => 1,
                   :memorize_count => 0
                   )
    end
    trans = nil
  end
end

