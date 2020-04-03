# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: 'Empty field!') && return
    else
      @parameter = params[:search].downcase
      @results = Category.where('lower(name) LIKE :search', search: @parameter)
    end
  end
end
