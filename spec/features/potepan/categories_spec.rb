require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { build(:image) }
  
  background do
    product.images << image
    visit potepan_category_path(taxon.id)
  end
  
  scenario 'タイトル表示がカテゴリー名に' do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
  end
  
  scenario '商品数を正しく表示' do
    expect(page).to have_selector('.productBox', count: taxon.all_products.count)
  end

  scenario "サイドバーの商品数が正しいこと" do
    expect(page).to have_selector("ul > li", text: taxon.products.count)
  end
  
  scenario 'CategoriesまたはBrandをクリックしたらカテゴリー一覧が表示' do
    taxon.leaves.each do |category|
      expext(page).to have_content category.id
      expext(page).to have_content category.name
      expext(page).to have_content category.products.count
    end
  end

  it "商品詳細ページへ" do
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end
end
