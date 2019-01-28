class CreateAppointmentApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_applications do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.integer :status, default: 1
      t.boolean :send_by_employer, default: false

      t.timestamps
    end
    add_index :appointment_applications, :appointment_id
    add_index :appointment_applications, :user_id
    add_index :appointment_applications, [:appointment_id, :user_id], unique: true
  end
end
