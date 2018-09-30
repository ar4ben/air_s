class GuestReviewsController < ApplicationComtroller
  def create
    #Check if reservation exists

    #Check if current host already reviewed the guest in this reservation
    @reservation = Reservation.where(
                    id: guest_reviews_params[:reservation_id],
                    room_id: guest_reviews_params[:room_id]
                   ).first

    unless @reservation.nil? && @reservation.room.user.id == guest_reviews_params[:host_id]
      @has_reviewed = GuestReview.where(
                        reservation_id: guest_reviews_params[:reservation_id],
                        host_id: guest_reviews_params[:host_id]
                      ).first

      if @has_reviewed.nil?
        @guest_review = current_user.guest_reviews.create(guest_reviews_params)
        flash[:success] = "Review created"
      else
        flash[:success] = "You already have reviewed this reservation"
      end
    else
      flash[:alert] = "Not found this reservation"
    end

    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @guest_review = Review.find(params[:id])
    @guest_review.destroy

    redirect_back(fallback_location: root_path, notice: "Removed")
  end  

  private
    def guest_reviews_params
      params.require(:guest_review).permit(:comment. :star, :room_id, :reservation_id, :host_id)
    end
end