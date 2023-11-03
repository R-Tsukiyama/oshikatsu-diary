class Post < ApplicationRecord
  acts_as_taggable_on :tags
  mount_uploader :image, PostimageUploader
  belongs_to :user
  geocoded_by :address
  after_validation :geocode

  validates :title, presence: true
  validates :date, presence: { message: "日付を選択してください" }
  
  def start_time
    self.date
  end
end
