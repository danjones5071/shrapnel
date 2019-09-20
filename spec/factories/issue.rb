FactoryBot.define do
  factory :issue do
    assignee { Faker::FunnyName.name }
    description{ Faker::Hacker.say_something_smart }
    due_date { Faker::Date.forward }
    estimate { Faker::Number.between(from: 1, to: 20) }
    issue_status { Faker::Beer.style }
    issue_type { Faker::Beer.brand }
    subject { Faker::Movie.quote }
  end
end