class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(:root)
    @products = @taxon.all_products.includes(master: [:images, :default_price])
  end
end
