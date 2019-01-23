class AddIndexToUsersCityId < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :city_id
  end
end
