FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    image { '/images/' + %w(photo.jpg.png picture.jpeg default_profile_1_normal.png).sample }
    uid { User.all.pluck(:uid).max.try(:next) || 2_342_352_352_352_422_342 }
    provider { %w(facebook twitter google vkontakte).sample }
  end
end
