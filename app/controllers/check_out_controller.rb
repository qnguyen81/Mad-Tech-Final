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
end
