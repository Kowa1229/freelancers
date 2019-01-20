class Category < ApplicationRecord
  # has_many :user_category
  has_and_belongs_to_many :users
end
