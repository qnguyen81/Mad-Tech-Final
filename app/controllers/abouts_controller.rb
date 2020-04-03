# frozen_string_literal: true

class AboutsController < ApplicationController
  def index
    @abouts = About.all
  end
end
