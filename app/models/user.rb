class User < ApplicationRecord
  attr_accessor :current_password

  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validate :password_complexity

  validates :current_password, presence: true, if: :requires_current_password?
  validate :current_password_is_correct, if: :requires_current_password?

  private

  def requires_current_password?
    persisted? && (will_save_change_to_email? || will_save_change_to_encrypted_password?)
  end

  def current_password_is_correct
    actual_encrypted_password = User.find(id).encrypted_password
    return if Devise::Encryptor.compare(self.class, actual_encrypted_password, current_password)

    errors.add(:current_password, 'is invalid')
  end

  def password_complexity
    return if password.blank?

    errors.add :password, 'must include at least one lowercase letter' unless password.match?(/[a-z]/)
    errors.add :password, 'must include at least one uppercase letter' unless password.match?(/[A-Z]/)
    errors.add :password, 'must include at least one digit' unless password.match?(/\d/)
    return if password.match?(/[@$!%*#?&]/)

    errors.add :password, 'must include at least one special character'
  end

  def password_required?
    new_record? || password.present?
  end
end
