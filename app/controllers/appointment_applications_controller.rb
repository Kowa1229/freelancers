class AppointmentApplicationsController < ApplicationController

  def create
    # Check is there any request on this user before
    if user_request_before?(params[:user_id], params[:appointment_id])
      @appointment_application = AppointmentApplication.find_by(user_id: params[:user_id],
                                                                 appointment_id: params[:appointment_id])
      @appointment_application.status = 1

      @message = "Request resent!"
    else
      @appointment_application = AppointmentApplication.new(user_id: params[:user_id],
                                                            appointment_id: params[:appointment_id])
      @message = "Request sent!"
    end

    @appointment = Appointment.find(params[:appointment_id])

    if @appointment_application.save
      flash[:success] = @message
      redirect_to appointment_path(@appointment)
    end

  end

  def update
    @appointment_application = AppointmentApplication.find(params[:id])
    @appointment_application.status = params[:status]

    @appointment = Appointment.find(params[:appointment_id])

    if @appointment_application.save
      flash[:success] = "Request cancelled."
      redirect_to appointment_path(@appointment)
    end
  end

end
