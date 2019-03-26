class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_auth_token
    self.auth_token = SecureRandom.hex
    self.token_is_valid = true
    self.save
  end

  def remove_auth_token
    self.auth_token = ''
    self.token_is_valid = false
    self.save
  end
end
