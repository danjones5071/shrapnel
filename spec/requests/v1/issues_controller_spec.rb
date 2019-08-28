require 'rails_helper'

RSpec.describe 'Issues Controller', type: :request do

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
      it 'returns a 404 not found response code' do
        get "/api/v1/issues/1", as: :json
        expect(response).to have_http_status(:not_found)
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
        before(:all) do
          get "/api/v1/issues/#{issue_count}", as: :json
        end
        it 'returns a 200 success response code' do
          expect(response).to have_http_status(:ok)
        end
        it 'returns a non-nil response' do
          expect(response).not_to be(nil)
        end
        it 'returns an issue with all the expected keys' do
          issue_att = FactoryBot.attributes_for :issue
          issue_att.stringify_keys!
          parsed_response = JSON.parse(response.body)
          excluded = ["id", "created_at", "updated_at"]
          expect(parsed_response.keys.without(*excluded)).to eq(issue_att.keys)
        end
      end
      context 'when the specified issue ID does not exist' do
        it 'returns a 404 not found response code' do
          get "/api/v1/issues/#{issue_count + 1}", as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
      context 'when an ID of 0 is requested' do
        it 'returns a 404 not found response code' do
          get "/api/v1/issues/0", as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
      context 'when a negative ID is requested' do
        it 'returns a 404 not found response code' do
          get "/api/v1/issues/-1", as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
      context 'when a non-numerical ID is requested' do
        it 'returns a 404 not found response code' do
          get "/api/v1/issues/invalid", as: :json
          expect(response).to have_http_status(:not_found)
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
        issue_att = FactoryBot.attributes_for :issue
        before(:all) do
          post "/api/v1/issues", { params: issue_att, as: :json }
        end
        it 'returns a 201 created response code' do
          expect(response).to have_http_status(:created)
        end
        it 'returns a response contaning the same attributes as the request' do
          parsed_response = JSON.parse(response.body)
          excluded = ["id", "created_at", "updated_at"]
          parsed_att = JSON.parse(issue_att.to_json)
          expect(parsed_response.without(*excluded)).to eq(parsed_att)
        end
      end
      context 'when all optional attributes are missing' do
        issue_att = FactoryBot.attributes_for :issue
        before(:all) do
          optional = [
            :description,
            :assignee,
            :estimate,
            :due_date
          ]
          optional.each do |op|
            issue_att.delete(op)
          end
          post "/api/v1/issues", { params: issue_att, as: :json }
        end
        it 'returns a 201 created response code' do
          expect(response).to have_http_status(:created)
        end
        it 'returns a response contaning the same attributes as the request' do
          parsed_response = JSON.parse(response.body).compact
          excluded = ["id", "created_at", "updated_at"]
          parsed_att = JSON.parse(issue_att.to_json)
          expect(parsed_response.without(*excluded)).to eq(parsed_att)
        end
      end
      context 'with one missing attribute' do
        issue_att = FactoryBot.attributes_for :issue
        it 'returns a 201 created response code without "assignee"' do
          post "/api/v1/issues", { params: issue_att.without(:assignee), as: :json }
          expect(response).to have_http_status(:created)
        end
        it 'returns a 201 created response code without "description"' do
          post "/api/v1/issues", { params: issue_att.without(:description), as: :json }
          expect(response).to have_http_status(:created)
        end
        it 'returns a 201 created response code without "due_date"' do
          post "/api/v1/issues", { params: issue_att.without(:due_date), as: :json }
          expect(response).to have_http_status(:created)
        end
        it 'returns a 201 created response code without "estimate"' do
          post "/api/v1/issues", { params: issue_att.without(:estimate), as: :json }
          expect(response).to have_http_status(:created)
        end
        it 'returns a 422 unprocessible entity response code without "issue_status"' do
          post "/api/v1/issues", { params: issue_att.without(:issue_status), as: :json }
          expect(response).to have_http_status(:unprocessable_entity)
        end
        it 'returns a 422 unprocessible entity response code without "issue_type"' do
          post "/api/v1/issues", { params: issue_att.without(:issue_type), as: :json }
          expect(response).to have_http_status(:unprocessable_entity)
        end
        it 'returns a 422 unprocessible entity response code without "subject"' do
          post "/api/v1/issues", { params: issue_att.without(:subject), as: :json }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
      context 'when the request body contains an additional attribute' do
        issue_att = FactoryBot.attributes_for :issue
        excluded = ["id", "created_at", "updated_at"]
        before(:all) do
          post "/api/v1/issues", { params: issue_att.merge(unknown: 'abcd'), as: :json }
        end
        it 'returns a 201 created response code' do
          expect(response).to have_http_status(:created)
        end
        it 'returns a response body containing correct attributes' do
          parsed_response = JSON.parse(response.body)
          parsed_att = JSON.parse(issue_att.to_json)
          expect(parsed_response.without(*excluded)).to eq(parsed_att)
        end
      end
      context 'when the request body is empty' do
        it 'throws a param missing error' do
          expect {
            post "/api/v1/issues", { params: "", as: :json }
          }.to raise_error(ActionController::ParameterMissing)
        end
      end
      context 'when the request body is nil' do
        it 'throws a param missing error' do
          expect {
            post "/api/v1/issues", { params: nil, as: :json }
          }.to raise_error(ActionController::ParameterMissing)
        end
      end
    end
  end

  # PUT
  describe 'Updating an existing Issue' do
    context 'with a valid request URL' do
      context 'when there are no existing issues' do
        before(:all) do
          DatabaseCleaner.clean_with(:truncation)
        end
        it 'returns a 404 not found response code' do
          put "/api/v1/issues/1", as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
      context 'when there are existing issues' do
        issue_count = 10
        before(:all) do
          DatabaseCleaner.clean_with(:truncation)
          FactoryBot.create_list(:issue, issue_count)
          selected_issue = Faker::Number.between(from: 1, to: issue_count)
        end
        context 'when the specified issue ID does not exist' do
          it 'returns a 404 not found response code' do
            put "/api/v1/issues/#{issue_count + 1}", as: :json
            expect(response).to have_http_status(:not_found)
          end
        end
        context 'when the request body contains a single attribute' do
          issue_att = FactoryBot.attributes_for :issue
          single_att = { 'subject'=>'test subject' }
          excluded = ["id", "created_at", "updated_at"]
          before(:all) do
            put "/api/v1/issues/1", { params: issue_att.merge(single_att), as: :json }
          end
          it 'returns a 200 success response code' do
            expect(response).to have_http_status(:ok)
          end
          it 'returns a response body containing the updated attribute' do
            parsed_response = JSON.parse(response.body)
            parsed_att = JSON.parse(issue_att.to_json)
            expect(parsed_response['subject']).to eq(single_att['subject'])
          end
          it 'does not alter any other attributes' do
            parsed_response = JSON.parse(response.body)
            parsed_att = JSON.parse(issue_att.to_json)
            to_exclude = excluded << 'subject'
            expect(parsed_response.without(*to_exclude)).to eq(parsed_att.without('subject'))
          end
        end
        context 'when the request body contains all attributes' do
          issue_att = FactoryBot.attributes_for :issue
          excluded = ["id", "created_at", "updated_at"]
          before(:all) do
            put "/api/v1/issues/1", { params: issue_att, as: :json }
          end
          it 'returns a 200 success response code' do
            expect(response).to have_http_status(:ok)
          end
          it 'returns a response body containing the same attributes' do
            parsed_response = JSON.parse(response.body)
            parsed_att = JSON.parse(issue_att.to_json)
            expect(parsed_response.without(*excluded)).to eq(parsed_att)
          end
        end
        context 'when the request body contains an additional attribute' do
          issue_att = FactoryBot.attributes_for :issue
          excluded = ["id", "created_at", "updated_at"]
          before(:all) do
            put "/api/v1/issues/1", { params: issue_att.merge(unknown: 'abcd'), as: :json }
          end
          it 'returns a 200 success response code' do
            expect(response).to have_http_status(:ok)
          end
          it 'returns a response body containing correct attributes' do
            parsed_response = JSON.parse(response.body)
            parsed_att = JSON.parse(issue_att.to_json)
            expect(parsed_response.without(*excluded)).to eq(parsed_att)
          end
        end
        context 'when no request body is provided' do
          it 'throws a param missing error' do
            expect {
              put "/api/v1/issues/1", as: :json
            }.to raise_error(ActionController::ParameterMissing)
          end
        end
        context 'when the request body is empty' do
          it 'throws a param missing error' do
            expect {
              put "/api/v1/issues/1", { params: "", as: :json }
            }.to raise_error(ActionController::ParameterMissing)
          end
        end
        context 'when the request body is nil' do
          it 'throws a param missing error' do
            expect {
              put "/api/v1/issues/1", { params: nil, as: :json }
            }.to raise_error(ActionController::ParameterMissing)
          end
        end
      end
    end
    context 'without an Issue ID in the request URL' do
      it 'throws a routing error' do
        expect {
          issue_att = FactoryBot.attributes_for :issue
          put "/api/v1/issues", { params: issue_att, as: :json }
        }.to raise_error(ActionController::RoutingError)
      end
    end
    context 'when an ID of 0 is requested' do
      it 'returns a 404 not found response code' do
        put "/api/v1/issues/0", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'when a negative ID is requested' do
      it 'returns a 404 not found response code' do
        put "/api/v1/issues/-1", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'when a non-numerical ID is requested' do
      it 'returns a 404 not found response code' do
        put "/api/v1/issues/invalid", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # DELETE
  describe 'Deleting an Issue' do
  end

end
