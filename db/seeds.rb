require 'factory_girl_rails'

FactoryGirl.create_list(:user, 20)     # Create list of faked users
FactoryGirl.create_list(:post, 100)    # Seeding posts
FactoryGirl.create_list(:comment, 400) # Randomly add comments
