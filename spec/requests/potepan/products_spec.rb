# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Potepan::Products', type: :request do
  describe 'GET /show' do
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:taxonomy) { create(:taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }

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
  end
end
