class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions
  has_many :user_emails
  has_many :categories

  after_create :create_user_email

  def full_name
    "#{self.name} #{self.last_name}".titleize
  end

  private

  def create_user_email
    unless UserEmail.find_by(address: self.email).present?
      UserEmail.create(user: self, address: self.email)
    end
  end
end
