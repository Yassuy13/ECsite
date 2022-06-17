require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /show" do
    let(:product) { create(:product) }

    before do
      get potepan_products_path(product.id)
    end

    it "商品詳細ページの表示" do
      expect(response).to have_http_status(200)
    end
    
    it "画像やテキストの内容を表示" do
      product.images.each do |image|
        expect(response.body).to include image.attachment(:product)
        expect(response.body).to include image.attachment(:small)
      end
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end
