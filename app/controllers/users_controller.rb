class UsersController < ApplicationController
  before_action :authenticate_user!

  helper_method :friend?
  helper_method :request_sent?
  helper_method :request_received_from?
  helper_method :send_friend_request_path
  helper_method :accept_friend_request_path
  helper_method :reject_friend_request_path

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def friend?(user)
    current_user.friends? user
  end

  def request_sent?(user)
    user.friend_responses.one? { |u| u.id == current_user.id }
  end

  def request_received_from?(user)
    current_user.friend_responses.detect { |response| response.id == user.id }
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

  def accept_friend_request_path(user)
    "/accept_friend_request?user_id=#{user.id}"
  end

  def reject_friend_request_path(user)
    "/reject_friend_request?user_id=#{user.id}"
  end

  def friend_requests
    @requests = current_user.pending_friend_requests
  end

  def friend_responses
    @responses = current_user.friend_responses
  end

  def accept_friend_request
    Friendship.where(user_1: params[:user_id], user_2: current_user.id)
      .update(status: 'Accepted')
    redirect_to '/friend_responses'
  end

  def reject_friend_request
    Friendship.where(user_1: params[:user_id], user_2: current_user.id)
      .update(status: 'Rejected')
    redirect_to '/friend_responses'
  end
end
