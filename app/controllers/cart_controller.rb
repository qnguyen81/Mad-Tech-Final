# frozen_string_literal: true

class CartController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create; end

  def index
    @cart = session[:cart] if session[:cart].present?
    @productid = []
    @cart&.each_key { |key| @productid.push(key) }
    @products = Product.where(id: @productid)
  end

  def add_quantity
    @cart ||= {}
    @cart = session[:cart] if session[:cart].present?
    @productid = params[:id]
    @quantity = params[:quantity].to_i + 1
    @new_hash = { @productid => @quantity }
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

  def add_to_cart
    @cart ||= {}
    @cart = session[:cart] if session[:cart].present?
    @products = Product.find(params[:id])
    @quality = params[:quality]
    @new_hash = { @products.id => @quality }
    @cart.merge!(@new_hash)
    session[:cart] = @cart
  end

  def remove_from_cart
    @cart = session[:cart] if session[:cart].present?
    @cart.delete(params[:id])
    flash[:success] = 'The item was removed successfully'
    session[:cart] = @cart
    redirect_to '/cart'
  end
end
