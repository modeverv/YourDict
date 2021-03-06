class User < ActiveRecord::Base
  has_many :word
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  devise :trackable, :omniauthable

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         #                          email:auth.info.email, #emailを取得したい場合は、migrationにemailを追加してください。
                         password:Devise.friendly_token[0,20]
                         )
    end
    user
  end


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:auth.info.nickname,
                         provider:auth.provider,
                         uid:auth.uid,
                         #                          email:auth.extra.user_hash.email, #色々頑張りましたがtwitterではemail取得できません
                         password:Devise.friendly_token[0,20]
                         )
    end
    user
  end
  
end
