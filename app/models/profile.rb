class Profile < ActiveRecord::Base
  belongs_to :user

  with_options presence: true, on: :update do |profile|
    profile.validates :first_name
    profile.validates :last_name
  end

  before_update :update_status

  def completed?
    status == 'completed'
  end

  protected

  def update_status
    self.status = 'completed' if status == 'pending'
  end
end
