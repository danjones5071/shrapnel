FactoryBot.define do
  factory :issue do
    issue_type { SecureRandom.uuid }
    subject { SecureRandom.uuid }
    issue_status { SecureRandom.uuid }
  end
end