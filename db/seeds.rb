# Create list of faked users
20.times do
  User.create(name: Faker::Name.name,
              nickname: Faker::Internet.user_name,
              email: Faker::Internet.email,
              password: Faker::Internet.password,
              image: '/assets/images/' + %w(photo.jpg.png picture.jpeg default_profile_1_normal.png).sample,
              uid: User.all.pluck(:uid).max.try(:next) || 2_342_352_352_352_422_342,
              provider: %w(facebook twitter google vkontakte).sample )
end

# Seeding posts
100.times do
  Message.create(body: Faker::Lorem.sentence(7, true, 4),
                 user: User.all.sample,
                 created_at: Faker::Time.between(1.year.ago, Time.now.utc, :all),
                 parent_id: nil)
end

# Randomly add comments
500.times do
  Message.create(body: Faker::Lorem.sentence(7, true, 4),
                 user: User.all.sample,
                 created_at: Faker::Time.between(1.year.ago, Time.now.utc, :all),
                 parent_id: Message.all.pluck(:id).sample)
end
