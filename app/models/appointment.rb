class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :category

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

end
