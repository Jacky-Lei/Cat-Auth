# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#
require 'bcrypt'

class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  after_initialize :reset_session_token

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if user && user.is_password?(password)
  end

  def reset_session_token
    self.session_token ||= SecureRandom.hex(5)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end
