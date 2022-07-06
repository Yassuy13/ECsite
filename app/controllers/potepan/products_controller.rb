# frozen_string_literal: true

module Potepan
  class ProductsController < ApplicationController
    RELATED_PRODUCTS_MAX_COUNT = 4

    def show
      @product = Spree::Product.find(params[:id])
      @related_products = @product.related_products.includes(master: [:images, :default_price]).limit(RELATED_PRODUCTS_MAX_COUNT)
    end
  end
end
