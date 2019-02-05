class AppointmentsController < ApplicationController
  before_action :employer?, only: [:new, :create]
  before_action :logged_in_user
  before_action :is_owner?, only: [:edit, :update, :accept_applicants, :reject_applicants]
  after_action :check_pax, only: [:accept_applicants]

  @@appointment_owner_message = "Only appointment owner can perform this action."
  @@employer_only_message = "Only employer are allow to perform this action."
  @@unable_to_update = "Only employer are allow to perform this action."

  def new
    @appointment = Appointment.new
    @appointment.city_id = current_user.city.id
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:info] = "Appointment created."
      redirect_to @appointment
    else
      render 'new'
    end
  end

  def index
    @appointments = Appointment.all
    # @appointments = current_user.opportunities(current_user.category_ids, current_user.city_id)
    @running_app = current_user.progress_appointment(current_user)
    @completed_app = current_user.completed_appointment(current_user)
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

  def accept_applicants
    AppointmentApplication.where('id IN (?)', params[:applicant_ids]).update_all(status: 2)
    flash[:success] = "Applicants accepted!"

    @appointment = Appointment.find(params[:appointment_id])
    redirect_to appointment_path(@appointment)
  end

  def reject_applicants
    AppointmentApplication.where('id IN (?)', params[:applicant_ids]).update_all(status: 3)
    flash[:success] = "Applicants rejected!"

    @appointment = Appointment.find(params[:appointment_id])
    redirect_to appointment_path(@appointment)
  end

  private
  def appointment_params
    # params.require(:appointment).permit!
    params.require(:appointment).permit(:user_id, :category_id, :city_id,
                                        :pax, :title, :description, :address,
                                        :location, :status,
                                        appointment_sessions_attributes: [:id, :time, :_destroy])
  end

  def is_owner?
    appointment = Appointment.find(params[:appointment_id] || params[:id])
    flash[:danger] = @@appointment_owner_message and redirect_to appointment unless appointment.appointment_owner?(current_user)
  end

  def check_pax
    appointment = Appointment.find(params[:appointment_id])
    if appointment.pax == appointment.approve_applicants.count
      appointment.update_status_to_progress
    end
  end

  def employer?
    flash[:danger] = @@employer_only_message and redirect_to opportunities_path unless current_user.is_employer?
    # redirect_to opportunities_path
  end
end
