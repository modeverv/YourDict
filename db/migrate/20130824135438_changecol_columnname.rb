class ChangecolColumnname < ActiveRecord::Migration
  def change
    rename_column(:words, :userid, :user_id)
  end
end
