class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :book_id, :presence => true
  validates :details, :presence => true
end
