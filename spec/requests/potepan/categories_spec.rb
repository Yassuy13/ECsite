require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:taxonomy) { create(:taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_category_path(taxon.id)
    end

    it "商品カテゴリーページの表示" do
      expect(response).to have_http_status(200)
    end

    it "taxon名の取得" do
      expect(response.body).to include taxon.name
      expect(response.body).to include taxon.products.count.to_s
    end

    it "taxonomy名の取得" do
      expect(response.body).to include taxonomy.name
    end
  end
end
