class User < ApplicationRecord
  VALID_EMAIL_REGEX = Regexp.new(Settings.user.email.regex)
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
