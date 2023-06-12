# spec/factories/tasks.rb

FactoryBot.define do
  factory :task do
    title { Faker::Name.unique.name }
    description { Faker::Lorem.sentence }
    status { 'pending' }
    priority { 'low' }
    deadline { Faker::Time.forward(days: 7) }
    association :user, factory: :user
  end
end
