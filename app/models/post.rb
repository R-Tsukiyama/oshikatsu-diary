class Post < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :user

  validates :title, presence: true
  validates :date, presence: { message: "日付を選択してください" }
end
