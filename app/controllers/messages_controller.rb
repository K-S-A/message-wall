class MessagesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_message, only: [:edit, :update]
  respond_to :js

  def index
    @message = Message.new
    @messages = params[:id] ? comments_list : paginated_posts_list
  end

  def new
    @message = Message.new(parent_id: params[:id])
  end

  def create
    @message = current_user.messages.create!(message_params)
  end

  def edit
  end

  def update
    @message.update!(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:body, :parent_id)
  end

  def find_message
    @message = current_user.messages.find(params[:id])
  end

  def comments_list
    Message.find(params[:id]).comments
  end

  def paginated_posts_list
    Message.paginate(page: params[:page]).order(created_at: :desc).roots
  end
end
