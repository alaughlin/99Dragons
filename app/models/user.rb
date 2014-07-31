class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: {minimum: 5}, allow_nil: true

  has_many(
    :dragons,
    :class_name => 'Dragon',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :rental_requests,
    :class_name => 'DragonRentalRequest',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  # def reset_session_token!
#     self.session_token = SecureRandom.urlsafe_base64
#     self.save!
#   end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    pw = BCrypt::Password.new(self.password_digest)
    pw.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.where(username: username).first
    if user.is_password?(password)
      user
    end
  end
end