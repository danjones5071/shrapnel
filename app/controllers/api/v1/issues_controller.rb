module Api::V1
  class IssuesController < ApplicationController
    respond_to :json

    def index
      respond_with Issue.order(id: :DESC)
    end

    def show
      respond_with Issue.find(params[:id])
    end
  end
end