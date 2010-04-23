class CreatePasswords < ActiveRecord::Migration
  def self.up
    create_table :passwords do |t|
      t.column  :user_id,           :integer
      t.column  :hashed_password,   :string
      t.column  :salt,              :string
      t.timestamps
    end
  end

  def self.down
    drop_table :passwords
  end
end
