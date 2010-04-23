Group.create(:name => 'admin')
Group.create(:name => 'member')

user = User.create( :group_id => '1',
                    :name => 'admin')

Password.create(  :user_id => '1',
                  :hashed_password => '111')

Passport.create(  :user_id => '1',
                  :real_name => "Mr Dimi"
                )

Avatar.create(  :user_id => '1',
                :url => 'http://s51.radikal.ru/i132/1003/02/68907fc31d50.jpg')

Message.create( :user_id => user.id,
                :user_name => user.name,
                :user_message_number => user.messages.size,
                :user_register_date => user.created_at,
                :user_group => user.group.name,
                :user_avatar => user.avatar.url,
                :content => 'welcome'
              )

