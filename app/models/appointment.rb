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

  # def pending_applicants
  #   return applicants.find_by(status: 1)
  # end

end
