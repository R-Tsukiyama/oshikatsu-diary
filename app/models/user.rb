class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  validates :profile, length: { maximum: 200 }
  mount_uploader :userimage, ImageUploader
  
  before_create :generate_user_id

  private

  def generate_user_id
    loop do
      self.user_id = SecureRandom.hex(8)
      break unless self.class.exists?(user_id: user_id)
    end
  end
end
