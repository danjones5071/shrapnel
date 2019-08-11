require 'rails_helper'

RSpec.describe 'IssuesController', type: :request do

  # GET
  describe 'Retrieving all issues' do
    context 'when there are no existing issues' do
      before(:all) do
        DatabaseCleaner.clean_with(:truncation)
        get "/api/v1/issues", as: :json
      end
      it 'returns a 200 success response code' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns a non-nil response' do
        expect(response).not_to be(nil)
      end
      it 'does not return any issues' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(0)
      end
    end
    context 'when there are existing issues' do
      issue_count = Faker::Number.between(from: 1, to: 10)
      before(:all) do
        DatabaseCleaner.clean_with(:truncation)
        FactoryBot.create_list(:issue, issue_count)
        get "/api/v1/issues", as: :json
      end
      it 'returns a 200 success response code' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns a non-nil response' do
        expect(response).not_to be(nil)
      end
      it 'returns the correct number of issues' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(issue_count)
      end
    end
  end

  # GET:id
  describe 'Retrieving a single issue by ID' do
    context 'when there are no existing issues' do
      before(:all) do
        DatabaseCleaner.clean_with(:truncation)
      end
      it 'throws a record not found error' do
        expect {
          get "/api/v1/issues/1", as: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    context 'when there are existing issues' do
      issue_count = 10
      before(:all) do
        DatabaseCleaner.clean_with(:truncation)
        FactoryBot.create_list(:issue, issue_count)
        selected_issue = Faker::Number.between(from: 1, to: issue_count)
      end
      context 'when the issue is found' do
        it 'returns a 200 success response code' do
          get "/api/v1/issues/#{issue_count + 0}", as: :json
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when the specified issue ID does not exist' do
        it 'throws a record not found error' do
          expect {
            get "/api/v1/issues/#{issue_count + 1}", as: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      context 'when an ID of 0 is requested' do
        it 'throws a record not found error' do
          expect {
            get "/api/v1/issues/0", as: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      context 'when a negative ID is requested' do
        it 'throws a record not found error' do
          expect {
            get "/api/v1/issues/-1", as: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      context 'when a non-numerical ID is requested' do
        it 'throws a record not found error' do
          expect {
            get "/api/v1/issues/invalid", as: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  # POST
  describe 'Creating a new Issue' do
    context 'with an issue ID in the request URL' do
      it 'throws a routing error' do
        expect {
          issue_att = FactoryBot.attributes_for :issue
          post "/api/v1/issues/1", { params: issue_att, as: :json }
        }.to raise_error(ActionController::RoutingError)
      end
    end
    context 'with a valid request URL' do
      context 'when all optional and required attributes are provided' do
        it 'returns 201 created response code' do
          issue_att = FactoryBot.attributes_for :issue
          post "/api/v1/issues", { params: issue_att, as: :json }
          expect(response).to have_http_status(:created)
        end
      end
    end
  end

end
