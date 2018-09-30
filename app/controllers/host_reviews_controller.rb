class HostReviewsController < ApplicationComtroller
  def create
    #Check if reservation exists

    #Check if current host already reviewed the guest in this reservation
    @reservation = Reservation.where(
                    id: host_reviews_params[:reservation_id],
                    room_id: host_reviews_params[:room_id],
                    user_id: host_reviews_params[:guest_id]
                   ).first

    unless @reservation.nil?
      @has_reviewed = HostReview.where(
                        reservation_id: host_reviews_params[:reservation_id],
                        guest_id: host_reviews_params[:guest_id]
                      ).first

      if @has_reviewed.nil?
        @host_review = current_user.host_reviews.create(host_reviews_params)
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
    @host_review = Review.find(params[:id])
    @host_review.destroy

    redirect_back(fallback_location: root_path, notice: "Removed")
  end  

  private
    def host_reviews_params
      params.require(:host_review).permit(:comment. :star, :room_id, :reservation_id, :guest_id)
    end
end