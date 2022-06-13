require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  before do
    get potepan_product_path(product.id)
  end
  describe "GET /show" do
    it "商品詳細ページの表示" do
      get "/potepan/products"
      expect(response).to have_http_status(200)
    end
  end
end