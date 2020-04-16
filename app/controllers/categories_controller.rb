# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name).page(params[:page]).per(2)
  end

  # GET /breeds/:id
  def show
    @category = Category.find(params[:id])
  end
end
