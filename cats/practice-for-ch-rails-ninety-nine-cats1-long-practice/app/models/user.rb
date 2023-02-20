# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
# u updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true

  before_validation :ensure_session_token

  def ensure_session_token
    session_token ||= generate_unique_session_token
  end

  def generate_unique_session_token
    token = SecureRandom::urlsafe_base64
    while User.exist?(session_token: token)
      token = SecureRandom::urlsafe_base64
    end
    token
  end

  def password=(password)
    password_digest = Bcrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    #converting password_digest(string) => bcrypt instance
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
