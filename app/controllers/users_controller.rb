class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms

    #all the guest reviews to this user as a host
    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)
    #all reviews to this user as a guest
    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
  end
end