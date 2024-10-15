class ProductsController < ApplicationController
  def index
    @products = Product.includes(:offers)
  end
end
