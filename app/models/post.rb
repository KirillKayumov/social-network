class Post < ActiveRecord::Base
  belongs_to :author, class_name: :User
  belongs_to :owner, class_name: :User

  has_many :likes, as: :likable, dependent: :destroy

  validates :text, :owner_id, :author_id, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def like_of(user)
    likes.find_by(user_id: user.id)
  end
end
