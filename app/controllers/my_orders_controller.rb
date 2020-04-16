# frozen_string_literal: true

class MyOrdersController < ApplicationController
  def index
    @customer = current_customer
    @orders = Order.where('customer_id = ?', @customer.id)
  end

  def show
    @customer = current_customer
    @order_id = params[:id]
    @order = Order.where('id = ? and customer_id = ?', @order_id, @customer.id).first
    @items = @order.order_details.all
  end
end
