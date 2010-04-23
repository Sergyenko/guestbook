class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.integer :user_id
      t.string  :url
    end
  end

  def self.down
    drop_table :avatars
  end
end
