class TransferCategoryEnumToCategoryIdValue < ActiveRecord::Migration[8.0]
  def change
    User.all.each do |user|
      ts = user.transactions

      other_category_category = user.categories.find_by(name: 'other_category')
      ts.where(category: :other_category).update_all(category_id: other_category_category.id)

      supermarket_category = user.categories.find_by(name: 'supermarket')
      ts.where(category: :supermarket).update_all(category_id: supermarket_category.id)

      transference_category = user.categories.find_by(name: 'transference')
      ts.where(category: :transference).update_all(category_id: transference_category.id)

      health_category = user.categories.find_by(name: 'health')
      ts.where(category: :health).update_all(category_id: health_category.id)

      investment_category = user.categories.find_by(name: 'investment')
      ts.where(category: :investment).update_all(category_id: investment_category.id)

      entertainment_category = user.categories.find_by(name: 'entertainment')
      ts.where(category: :entertainment).update_all(category_id: entertainment_category.id)

      home_category = user.categories.find_by(name: 'home')
      ts.where(category: :home).update_all(category_id: home_category.id)

      services_category = user.categories.find_by(name: 'services')
      ts.where(category: :services).update_all(category_id: services_category.id)

      transport_category = user.categories.find_by(name: 'transport')
      ts.where(category: :transport).update_all(category_id: transport_category.id)

      pet_category = user.categories.find_by(name: 'pet')
      ts.where(category: :pet).update_all(category_id: pet_category.id)

      charity_category = user.categories.find_by(name: 'charity')
      ts.where(category: :charity).update_all(category_id: charity_category.id)

      debts_category = user.categories.find_by(name: 'debts')
      ts.where(category: :debts).update_all(category_id: debts_category.id)

      delivery_category = user.categories.find_by(name: 'delivery')
      ts.where(category: :delivery).update_all(category_id: delivery_category.id)

      subscriptions_category = user.categories.find_by(name: 'subscriptions')
      ts.where(category: :subscriptions).update_all(category_id: subscriptions_category.id)

      clothing_category = user.categories.find_by(name: 'clothing')
      ts.where(category: :clothing).update_all(category_id: clothing_category.id)

      education_category = user.categories.find_by(name: 'education')
      ts.where(category: :education).update_all(category_id: education_category.id)

      travel_category = user.categories.find_by(name: 'travel')
      ts.where(category: :travel).update_all(category_id: travel_category.id)
    end
  end
end
