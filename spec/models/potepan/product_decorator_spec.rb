require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon]) }
  let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }

  it "関連商品を取得できていること" do
    expect(product.related_products).to eq related_products
  end

  it "表示されている商品が関連商品に含まれないこと" do
    expect(product.related_products).not_to include product
  end

  it "表示される商品が重複しないこと" do
    expect(product.related_products).to eq related_products.uniq
  end
end
