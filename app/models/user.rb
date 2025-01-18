class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  has_many :transactions
  has_many :user_emails
  has_many :categories

  after_create :create_user_email

  def self.from_omniauth(auth)
    # The auth hash may look like: auth.provider, auth.uid, auth.info.email, etc.
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize

    user.email = auth.info.email
    # For instance, you might want to set a random password for new users
    user.password = Devise.friendly_token[0, 20] unless user.encrypted_password.present?

    # For user data
    user.name = auth.info.name if user.respond_to?(:name)

    user.save
    user
  end

  private

  def create_user_email
    unless UserEmail.find_by(address: self.email).present?
      UserEmail.create(user: self, address: self.email)
    end
  end
end
