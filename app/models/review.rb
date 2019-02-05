class Review < ApplicationRecord

  belongs_to :appointment_application
  belongs_to :user, class_name: "User"
  # belongs_to :review_to

  # integer > rating
  # text > comment
  # integer  review_by
  # integer review to
  # integer appointment_application_id

  validates :rating, presence: true

end
