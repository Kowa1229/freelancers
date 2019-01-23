class AddCityAndTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :city_id, :integer
    add_column :users, :employer, :boolean
  end

end
