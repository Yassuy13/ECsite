# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Potepan::Categories', type: :request do
  describe 'GET /show' do
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:taxonomy) { create(:taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { build(:image) }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it '200レスポンスが返ってくること' do
      expect(response).to have_http_status(200)
    end

    it 'taxonomy名の取得できていること' do
      expect(response.body).to include taxonomy.name
    end

    it '商品名、価格、商品内容を取得していること' do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
    end
  end
end
