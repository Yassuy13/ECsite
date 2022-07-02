# frozen_string_literal: true

module Potepan
  class CategoriesController < ApplicationController
    def show
      @taxon = Spree::Taxon.find(params[:id])
      @taxonomies = Spree::Taxonomy.all.includes(:root)
      @products = @taxon.all_products.includes(master: %i(images default_price))
    end
  end
end
