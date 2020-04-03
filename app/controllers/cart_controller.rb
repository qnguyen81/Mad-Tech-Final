# frozen_string_literal: true

class CartController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @cart = session[:cart] if session[:cart].present?
    @product_id = []
    @cart&.each_key { |key| @product_id.push(key) }
    @products = Product.where(id: @product_id)
  end

  def add_to_cart
    @cart ||= {}
    @cart = session[:cart] if session[:cart].present?
    @products = Product.find(params[:id])
    @product_id = params[:product_id]
    @new_hash = { @products.id => @product_id }
    @cart.merge!(@new_hash)
    session[:cart] = @cart
  end

  def remove_from_cart
    @cart = session[:cart] if session[:cart].present?
    @cart.delete(params[:id])
    session[:cart] = @cart
    redirect_to '/cart'
  end

  def add_quantity
    @cart ||= {}
    @cart = session[:cart] if session[:cart].present?
    @product_id = params[:id]
    @quantity = params[:quantity].to_i + 1
    @new_hash = { @product_id => @quantity }
    @cart.merge!(@new_hash)
    session[:cart] = @cart
    redirect_to '/cart'
  end

  def subtract_quantity
    @cart ||= {}
    @cart = session[:cart] if session[:cart].present?
    @productid = params[:id]
    @quantity = params[:quantity].to_i - 1
    @quantity = 1 if @quantity == 0
    @new_hash = { @productid => @quantity }
    @cart.merge!(@new_hash)
    session[:cart] = @cart
    redirect_to '/cart'
  end
end
