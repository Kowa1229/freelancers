module AppointmentApplicationsHelper

  # Check user request this appointment before or not
  def user_request_before?(user_id, appointment_id)
    !AppointmentApplication.find_by(user_id: user_id, appointment_id: appointment_id).nil?
  end

end
