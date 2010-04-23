class CreatePassports < ActiveRecord::Migration
  def self.up
    create_table :passports do |t|
    t.integer :user_id
    t.string  :real_name
    t.string  :profession
    t.string  :city
    t.string  :country
    t.string  :email
    t.string  :site
    t.string  :skype
    t.string  :icq
    t.string  :sex
    t.string  :date_of_birth
    t.string  :photo
    end
  end

  def self.down
    drop_table :passports
  end
end
