require 'rails_helper'

RSpec.describe Issue, type: :model do
  let(:issue) { create(:issue) }

  describe 'length validations' do
    it { should validate_length_of(:issue_type).is_at_most(32) }
    it { should validate_length_of(:issue_status).is_at_most(32) }
  end

  describe 'presence validations' do
    it { should validate_presence_of(:issue_type) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:issue_status) }
  end
end