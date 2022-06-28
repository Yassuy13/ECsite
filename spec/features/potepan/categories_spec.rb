require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { build(:image) }
  given(:test_product) { create(:product) }
  
  background do
    product.images << image
    visit potepan_category_path(taxon.id)
  end
  
  scenario 'タイトル表示がカテゴリー名になること' do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
  end
  
  scenario '商品数を正しく表示されていること' do
    expect(page).to have_selector('.productBox', count: taxon.all_products.count)
  end

  scenario "サイドバーの商品数が正しいこと" do
    expect(page).to have_selector("ul > li", text: taxon.products.count)
  end
  
  scenario 'CategoriesまたはBrandのカテゴリー一覧を表示していること' do
    taxon.leaves.all? do |category|
      expext(page).to have_content category.id
      expext(page).to have_content category.name
      expext(page).to have_content category.products.count
    end
  end

  scenario "商品名から商品詳細ページへ遷移されること" do
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it '関連しない商品が表示されないこと' do
    within '.products_test' do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).not_to have_content test_product.name
    end
  end

  scenario "サイドバーのカテゴリーをクリックしたら選択カテゴリー画面へ遷移されること" do
    within ".side-nav" do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content "#{taxon.name} (#{taxon.products.count})"
      click_on "#{taxon.name} (#{taxon.products.count})"
      expect(current_path).to eq potepan_category_path(taxon.id)
    end
  end
end
