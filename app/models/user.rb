class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions
  has_many :user_emails
  has_many :categories

  after_create :create_user_email
  after_create :create_categories

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{self.name} #{self.last_name}".titleize
  end

  private

  def create_categories
    category_names = [
      "Otros",
      "Supermercado",
      "Salud",
      "Inversión",
      "Entretenimiento",
      "Hogar",
      "Servicios",
      "Transporte",
      "Mascota",
      "Regalo",
      "Entrega",
      "Suscripciones",
      "Ropa",
      "Educación",
      "Viaje"
    ]

    category_names.each do |name|
      Category.create(name: name, budget: 200, user: self)
    end
  end

  def create_user_email
    unless UserEmail.find_by(address: self.email).present?
      UserEmail.create(user: self, address: self.email)
    end
  end
end
