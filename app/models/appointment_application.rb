class AppointmentApplication < ApplicationRecord

  belongs_to :appointment, class_name: "Appointment"
  belongs_to :user, class_name: "User"

  # belongs_to :pending_appointment, -> { where status: 1}, class_name: "Appointment"

  validates :user_id, presence: true
  validates :appointment_id, presence: true

  def status_name(status)
    case status.to_s
      when "1"
        return "Waiting"
      when "2"
        return "Approved"
      when "3"
        return "Rejected"
      when "4"
        return "Canceled"
    end
  end

end
