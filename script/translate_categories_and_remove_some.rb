# User.all.each do |user|
#     user.categories.find_by(name: "other_category")&.update(name: "Otros")
#     user.categories.find_by(name: "supermarket")&.update(name: "Supermercado")
#     user.categories.find_by(name: "health")&.update(name: "Salud")
#     user.categories.find_by(name: "investment")&.update(name: "Inversión")
#     user.categories.find_by(name: "entertainment")&.update(name: "Entretenimiento")
#     user.categories.find_by(name: "home")&.update(name: "Hogar")
#     user.categories.find_by(name: "services")&.update(name: "Servicios")
#     user.categories.find_by(name: "transport")&.update(name: "Transporte")
#     user.categories.find_by(name: "pet")&.update(name: "Mascota")
#     user.categories.find_by(name: "charity")&.update(name: "Regalos")
#     user.categories.find_by(name: "delivery")&.update(name: "Delivery")
#     user.categories.find_by(name: "subscriptions")&.update(name: "Suscripciones")
#     user.categories.find_by(name: "clothing")&.update(name: "Ropa")
#     user.categories.find_by(name: "education")&.update(name: "Educación")
#     user.categories.find_by(name: "travel")&.update(name: "Viajes")
    
#     other_cat = user.categories.find_by(name: "Otros")
#     transference_cat = user.categories.find_by(name: "transference")
#     Transaction.where(category_id: transference_cat.id).update_all(category_id: other_cat.id)
#     transference_cat.delete
    
#     debts_cat = user.categories.find_by(name: "debts")
#     Transaction.where(category_id: debts_cat.id).update_all(category_id: other_cat.id)
#     debts_cat.delete
# end

# user = User.find 1
# user = User.find 34
# user = User.find 100
# user = User.find 101
