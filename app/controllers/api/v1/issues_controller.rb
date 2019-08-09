module Api::V1
  class IssuesController < ApplicationController
    respond_to :json

    def index
      respond_with Issue.order(id: :DESC)
    end

    def show
      respond_with Issue.find(params[:id])
    end

    def create
      respond_with :api, :v1, Issue.create(issue_params)
    end

    def destroy
      respond_with Issue.destroy(params[:id])
    end

    def issue_params
      params.require(:issue).permit(
        :id,
        :issue_type,
        :subject,
        :description,
        :issue_status,
        :assignee,
        :estimate,
        :due_date
      )
    end
  end
end