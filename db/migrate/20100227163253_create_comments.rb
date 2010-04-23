class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :user_id,    :integer
      t.column :user_name,  :string
      t.column :message_id, :integer
      t.column :comment,    :text
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
