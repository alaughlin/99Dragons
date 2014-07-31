class Session < ActiveRecord::Base
  validates :user_id, :token, presence: true

  after_initialize :set_session_token!

  def set_session_token!
    self.token ||= SecureRandom.urlsafe_base64
  end
end