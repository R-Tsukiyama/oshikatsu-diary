class Post < ApplicationRecord
  acts_as_taggable_on :tags
  mount_uploader :image, ImageUploader
  belongs_to :user

  validates :title, presence: true
  validates :location, presence: true
end
