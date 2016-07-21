class Book < ApplicationRecord
  belongs_to :user
  has_many :review,:dependent => :destroy
  has_many :coauthor,:dependent => :destroy
  has_many :ratings,:dependent => :destroy
  validates :name, :presence => true
  validates :description, :presence => true

  mount_uploader :picture, PictureUploader

  def self.search(search,userid)
    where("(name LIKE ? OR description LIKE ?) AND (user_id = ? OR ispublic = true)","%#{search}%","%#{search}%",userid)
    #where(" LIKE ?"")
  end
end
