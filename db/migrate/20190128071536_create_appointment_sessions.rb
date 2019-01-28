class CreateAppointmentSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_sessions do |t|
      t.integer :appointment_id, foreign_key: true
      t.datetime :time, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
