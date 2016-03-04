FactoryGirl.define do
  factory :message, aliases: [:post] do
    body { Faker::Lorem.sentence(7, true, 4) }
    user { User.all.sample }
    created_at { Faker::Time.between(1.year.ago, Time.now.utc, :all) }

    factory :comment do
      parent_id { Message.all.pluck(:id).sample }
    end
  end
end
