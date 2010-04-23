class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column  :user_id,             :integer
      t.column  :user_name,           :string
      t.column  :user_message_number, :integer
      t.column  :user_register_date,  :datetime
      t.column  :user_group,          :string
      t.column  :user_avatar,         :string
      t.column  :content, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
