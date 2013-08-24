class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :userid
      t.string :word
      t.string :translate
      t.integer :count
      t.integer :memorize_count
      t.timestamp :last_memorize_date

      t.timestamps
    end
  end
end
