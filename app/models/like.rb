class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user

  validates :user_id, :likable_id, :likable_type, presence: true
  validates :user_id, uniqueness: { scope: :likable_id }

  before_create :increase_count
  before_destroy :decrease_count

  protected

  def increase_count
    likable_type.constantize.find(likable_id).increment!(:likes_count)
  end

  def decrease_count
    likable_type.constantize.find(likable_id).decrement!(:likes_count)
  end
end
