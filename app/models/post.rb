class Post < ActiveRecord::Base
  belongs_to :author, class_name: :User
  belongs_to :owner, class_name: :User

  validates :text, presence: true
end
