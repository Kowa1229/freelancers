class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new
    @appointment.city_id = current_user.city.id
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      # Handle a successful save.
      # log_in @user
      # flash[:success] = "Welcome to Freelancer apps, #{@user.fullname}!"
      # redirect_to @user

      # @user.send_activation_email
      flash[:info] = "Appointment created."
      redirect_to @appointment

    else
      render 'new'
    end
  end

  def index
    @appointments = Appointment.all
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def appointment_params
    # params.require(:user).permit(:fullname, :username, :email,
    #                              :password, :password_confirmation)
    params.require(:appointment).permit(:user_id, :category_id, :city_id,
                                        :pax, :title, :description, :address,
                                        :location)
  end

end
