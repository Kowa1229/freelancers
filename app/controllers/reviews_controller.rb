class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    @appointment = Appointment.find(params[:appointment_id])

    if @review.save
      @review.reload
      flash[:info] = "Review added."
      redirect_to @appointment
    else
      flash[:danger] = @review.errors
      redirect_to @appointment
    end
  end

  private
  def review_params
    params.require(:review).permit!
  end

end
