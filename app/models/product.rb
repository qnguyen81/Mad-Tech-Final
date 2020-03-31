# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :product_image
  has_many :order_details
end
