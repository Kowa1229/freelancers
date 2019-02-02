class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :category

  has_many :applicants, class_name: "AppointmentApplication",
           foreign_key: "appointment_id",
           dependent: :destroy

  has_many :pending_applicants, -> { where status:1 } ,class_name: "AppointmentApplication",
           foreign_key: "appointment_id",
           dependent: :destroy

  has_many :approve_applicants, -> { where status:2 } ,class_name: "AppointmentApplication",
           foreign_key: "appointment_id",
           dependent: :destroy

  has_many :reject_applicants, -> { where status:3 } ,class_name: "AppointmentApplication",
           foreign_key: "appointment_id",
           dependent: :destroy

  has_many :cancel_applicants, -> { where status:4 } ,class_name: "AppointmentApplication",
           foreign_key: "appointment_id",
           dependent: :destroy

  # has_many :pending_applicants, through: :pending, source: :pending_appointment

  has_many :appointment_sessions, inverse_of: :appointment
  accepts_nested_attributes_for :appointment_sessions, allow_destroy: true,
                                reject_if: :all_blank

  validates :category_id, presence: true
  validates :city_id, presence: true
  validates :pax, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :location, presence: true

  def is_open?
    status_name(status) == "Open" ? true : false
  end

  def is_progress?
    status_name(status) == "Progress" ? true : false
  end

  def is_completed?
    status_name(status) == "Completed" ? true : false
  end

  def is_closed?
    status_name(status) == "Closed" ? true : false
  end

  def status_name(status)
    case status.to_s
      when "0"
        return "Open"
      when "1"
        return "Progress"
      when "2"
        return "Completed"
      when "3"
        return "Closed"
    end
  end

  def applicant_include?(user)
    !applicants.find_by(user_id: user.id, status: 1).nil?
  end

  def update_status_to_progress
    update_attribute(:status, 1)
  end

  def appointment_owner?(current_user)
    user_id == current_user.id
  end

end
