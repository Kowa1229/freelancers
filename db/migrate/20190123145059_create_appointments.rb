class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :city_id
      t.integer :pax
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.text :address
      t.string :location

      t.timestamps
    end
  end
end
