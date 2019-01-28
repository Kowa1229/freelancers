class CreateAppointmentSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_sessions do |t|
      t.integer :appointment_id
      t.datetime :time

      t.timestamps
    end
  end
end
