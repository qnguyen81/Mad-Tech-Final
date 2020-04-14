# frozen_string_literal: true

module CheckOutHelper
  def calculate_subtotal
    cart = session[:cart] if session[:cart].present?
    products = find_features
    sub_total = 0
    products.each do |product|
      sub_total += product.price.to_f * cart[product.id.to_s].to_f
    end
    sub_total
  end

  def find_features
    cart = session[:cart] if session[:cart].present?
    feature_ids = []
    cart&.each_key { |key| feature_ids.push(key) }
    products = Product.where(id: feature_ids)
    products
  end
end
