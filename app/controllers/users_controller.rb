class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :send_friend_request_path

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent

    @is_friend = current_user.friends.one? { |friend| friend.id == @user.id }
    @request_sent = @user.friend_responses.one? { |u| u.id == current_user.id }
    @request_received = current_user.friend_responses.detect { |response| response.id == @user.id }
  end

  def send_friend_request
    user_id = params[:user_id]
    user2 = User.find user_id
    Friendship.create(user1: current_user, user2: user2, status: 'Pending')
    redirect_to user_path id: user_id
  end

  def send_friend_request_path(user)
    "/send_friend_request?user_id=#{user.id}"
  end

  def friend_requests
    @requests = current_user.pending_friend_requests
  end

  def friend_responses
    @responses = current_user.friend_responses
  end
end
