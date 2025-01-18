class GenerateCategoriesToUsers < ActiveRecord::Migration[8.0]
  def change
    User.all.each do |user|
      Category.create(user: user, name: "other_category", budget: 200)
      Category.create(user: user, name: "supermarket", budget: 200)
      Category.create(user: user, name: "transference", budget: 200)
      Category.create(user: user, name: "health", budget: 200)
      Category.create(user: user, name: "investment", budget: 200)
      Category.create(user: user, name: "entertainment", budget: 200)
      Category.create(user: user, name: "home", budget: 200)
      Category.create(user: user, name: "services", budget: 200)
      Category.create(user: user, name: "transport", budget: 200)
      Category.create(user: user, name: "pet", budget: 200)
      Category.create(user: user, name: "charity", budget: 200)
      Category.create(user: user, name: "debts", budget: 200)
      Category.create(user: user, name: "delivery", budget: 200)
      Category.create(user: user, name: "subscriptions", budget: 200)
      Category.create(user: user, name: "clothing", budget: 200)
      Category.create(user: user, name: "education", budget: 200)
      Category.create(user: user, name: "travel", budget: 200)
    end
  end
end
