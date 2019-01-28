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
    # @appointments = current_user.opportunities(current_user.category_ids, current_user.city_id)
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(appointment_params)
      # Handle a successful update.
      flash[:success] = "Appointment updated"
      redirect_to @appointment
    else
      render 'edit'
    end
  end

  def destroy

  end

  private
  def appointment_params
    # params.require(:appointment).permit!
    params.require(:appointment).permit(:user_id, :category_id, :city_id,
                                        :pax, :title, :description, :address,
                                        :location, appointment_sessions_attributes: [:id, :time, :_destroy])
  end

end
