class Issue < ApplicationRecord
  validates :issue_type, :subject, :issue_status, presence: true
  validates :issue_type, :issue_status, length: { maximum: 32 }
end
