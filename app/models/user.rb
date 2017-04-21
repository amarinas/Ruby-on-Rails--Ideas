class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas
  has_many :likes, dependent: :destroy
  has_many :liked_idea, through: :likes, source: :idea
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :name, :alias, :email, presence: true
  validates :password, presence: true, length:{minimum: 7}

  validates :email, presence:true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_save :email_lowercase

def email_lowercase
  email.downcase!
end

end
