class Api::V1::IdeasController < Api::ApiController
  respond_to :json

  def index
    respond_with Idea.all
  end

  def show
    respond_with Idea.find(params[:id])
  end
end
