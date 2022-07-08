require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon2) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon3) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon]) }
  let!(:related_products) { create_list(:product, 5, taxons: [taxon, taxon2, taxon3]) }

  it "関連商品を取得できていること" do
    expect(product.related_products).to eq related_products
  end

  it "表示されている商品が関連商品に含まれないこと" do
    expect(product.related_products).not_to include product
  end

  it "複数のカテゴリーに属する商品が表示される商品に重複しないこと" do
    expect(product.related_products).to eq related_products.uniq
  end
end
