# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Potepan::Products', type: :request do
  describe 'GET /show' do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:related_product) { create_list(:product, 5, taxons: [taxon]) }

    before do
      get potepan_product_path(product.id)
    end

    it '200レスポンスが返ってくること' do
      expect(response).to have_http_status(200)
    end

    it 'テキストの内容を表示していること' do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end

    it "関連商品を5件作成し、4件のみが取得されていること" do
      within ".related_test" do
        expect(response.body).to include related_product[0].name
        expect(response.body).to include related_product[1].name
        expect(response.body).to include related_product[2].name
        expect(response.body).to include related_product[3].name
        expect(response.body).not_to include related_products[4].name
      end
    end
  end
end
