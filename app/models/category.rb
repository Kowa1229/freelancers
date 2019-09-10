class Category < ApplicationRecord
  # has_many :user_category
  has_and_belongs_to_many :users
  has_many :appointments

  has_many :open_appointments, -> { where status:0 } ,class_name: "Appointment",
           foreign_key: "category_id",
           dependent: :destroy

  has_many :progress_appointments, -> { where status:1 } ,class_name: "Appointment",
           foreign_key: "category_id",
           dependent: :destroy

  has_many :completed_appointments, -> { where status:2 } ,class_name: "Appointment",
           foreign_key: "category_id",
           dependent: :destroy

end
