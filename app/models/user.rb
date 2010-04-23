class User < ActiveRecord::Base
   has_many   :messages
   has_many   :comments
   has_one    :password
   has_one    :avatar
   has_one    :passport
   belongs_to :group

   validates_presence_of   :name, :message => "Name can't be blank!"
end
