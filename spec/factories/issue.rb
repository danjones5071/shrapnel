FactoryBot.define do
  factory :issue do
    issue_type { Faker::Beer.brand }
    issue_status { Faker::Beer.style }
    subject { Faker::Movie.quote }
    description{ Faker::Hacker.say_something_smart }
    assignee { Faker::FunnyName.name }
    estimate { Faker::Number.between(from: 1, to: 20) }
    due_date { Faker::Date.forward }
  end
end