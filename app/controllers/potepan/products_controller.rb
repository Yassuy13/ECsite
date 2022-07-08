# frozen_string_literal: true

module Potepan
  class ProductsController < ApplicationController
    MAX_PRODUCTS_COUNT = 4

    def show
      @product = Spree::Product.find(params[:id])
      @related_products = @product.related_products.includes(master: [:images, :default_price]).limit(MAX_PRODUCTS_COUNT)
    end
  end
end
