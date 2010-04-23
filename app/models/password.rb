class Password < ActiveRecord::Base
  belongs_to  :user

  def self.authenticate(name,password)
    auth = false
    user = User.find_by_name(name)
    if user
      user.password.hashed_password == password ? (auth = true) : (auth = false)
    end
    auth
  end
end
