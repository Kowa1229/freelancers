class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :profile_picture
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
