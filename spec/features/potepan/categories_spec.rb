require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { build(:image) }
  given(:shirts) { create(:taxon, name: "Shirts") }
  
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
  
  scenario 'CategoriesまたはBrandのカテゴリー一覧を表示' do
    taxon.leaves.each do |category|
      expext(page).to have_content category.id
      expext(page).to have_content category.name
      expext(page).to have_content category.products.count
    end
  end

  scenario "商品詳細ページへ" do
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end

  scenario '商品情報ページ及び関連しない商品が表示されないこと' do
    within '.products_test' do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).not_to have_content shirts.name
    end
  end

  scenario "サイドバーのカテゴリーをクリックしたら選択カテゴリー画面へ" do
    within ".side-nav" do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content "#{taxon.name} (#{taxon.products.count})"
      click_on "#{taxon.name} (#{taxon.products.count})"
      expect(current_path).to eq potepan_category_path(taxon.id)
    end
  end
end
