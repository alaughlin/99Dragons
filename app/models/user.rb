class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true

  after_initialize :reset_session_token!

  def reset_session_token!
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pw = BCrypt::Password.new(self.password_digest)
    pw.is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.where(username: user_name).first
    if user.is_password?(password)
      user
    end
  end
end