class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.all
    @products = Product.all
    render 'show'
  end
end
