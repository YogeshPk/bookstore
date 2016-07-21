class Category < ApplicationRecord
  validates :category_name, :presence => true
  validates :category_description, :presence => true

end
