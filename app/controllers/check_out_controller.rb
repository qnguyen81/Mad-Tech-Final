# frozen_string_literal: true

class CheckOutController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = current_customer
    @cart = session[:cart] if session[:cart].present?
    @features = helpers.find_features

    @province = Province.find(@customer.province_id)

    @sub_total = helpers.calculate_subtotal

    @gst = @province.gst
    @gst_total = (@province.gst / 100) * @sub_total
    @pst = @province.pst
    @pst_total = (@province.pst / 100) * @sub_total
    @hst = @province.hst
    @hst_total = (@province.hst / 100) * @sub_total
    @total_tax =  @hst_total + @gst_total + @pst_total

    @total = @total_tax + @sub_total
  end

  def create
    @total = params[:total].to_i
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Total: ',
        amount: @total * 100,
        currency: 'cad',
        quantity: 1
      }],
      success_url: check_out_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: check_out_index_url
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    @customer = current_customer

    @cart = session[:cart] if session[:cart].present?
    @product_ids = []

    @cart&.each_key { |key| @product_ids.push(key) }

    @products = helpers.find_features

    @province = Province.find(@customer.province_id)

    @sub_total = helpers.calculate_subtotal

    @gst = @province.gst
    @gst_total = (@province.gst / 100) * @sub_total
    @pst = @province.pst
    @pst_total = (@province.pst / 100) * @sub_total
    @hst = @province.hst
    @hst_total = (@province.hst / 100) * @sub_total
    @total_tax =  @hst_total + @gst_total + @pst_total

    @total = @sub_total + @total_tax

    @order = Order.create(status: 'Paid', amount: @total, address: @customer.address, gst: @gst,
                          pst: @pst, hst: @hst, customer_id: @customer.id)
    @products.each do |product|
      OrderDetail.create(name: product.name, description: product.description, price: product.price, quantity: @cart[product.id.to_s], category_id: product.category_id, order_id: @order.id)
    end

    session.delete(:cart)
  end

  def cancel; end
end
