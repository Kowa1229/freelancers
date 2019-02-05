class AddAppointmentApplicationRefToReview < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :appointment_application, foreign_key: true
  end
end
