# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Potepan::Categories', type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { build(:image) }
  given!(:differ_product) { create(:product) }

  background do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  scenario 'タイトル表示がカテゴリー名になること' do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
  end

  scenario '商品数が正しく表示されていること' do
    expect(page).to have_selector('.productBox', count: taxon.all_products.count)
  end

  scenario 'サイドバーの商品数が正しいこと' do
    expect(page).to have_selector('ul > li', text: taxon.products.count)
  end

  scenario 'CategoriesまたはBrandのカテゴリー一覧を表示していること' do
    within '.side-nav' do
      taxon.leaves.all? do |taxon|
        expext(page).to have_content taxon.name
        expext(page).to have_content taxon.products.count
      end
    end
  end

  scenario '商品名から商品詳細ページへ遷移されること' do
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it '関連しない商品が表示されないこと' do
    within '.products_test' do
      expect(page).not_to have_content differ_product.name
    end
  end

  context "別のtaxonが存在している時" do
    let!(:another_taxon) { create(:taxon, name: 'Another Taxon', taxonomy: taxonomy, parent: taxonomy.root) }

    before do
      visit potepan_category_path(another_taxon.id)
    end

    scenario 'サイドバーのカテゴリーをクリックし、別のカテゴリーへ遷移されること' do
      within '.side-nav' do
        click_on taxonomy.name
        expect(page).to have_selector 'li', text: taxon.name
        click_on taxon.name
        expect(current_path).to eq potepan_category_path(taxon.id)
      end
    end
  end
end
