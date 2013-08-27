class Word < ActiveRecord::Base
  belongs_to :user

  # 覚えていない
  scope :not_memorize , -> { where(:memorize_count => 0).order("updated_at") }
  # 覚えた
  scope :memorize , -> { where("memorize_count > 0").order("updated_at DESC") }
    
  # 最近覚えた
  scope :recent_memorize , -> { where("last_memorize_date > ?", 1.week.ago).order("updated_at DESC") }
  # 最近追加
  scope :recent_add , -> { order("created_at DESC") }
  # 出現回数順
  scope :many_count , -> { order("count DESC") }
  
  
end
