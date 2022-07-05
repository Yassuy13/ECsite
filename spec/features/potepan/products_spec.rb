# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Potepan::Products', type: :feature do
  given(:taxon) { create(:taxon, taxonomy: taxonomy) }
  given(:taxonomy) { create(:taxonomy) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:related_product) { create(:product, name: 'Related Product', taxons: [taxon]) }
  given!(:differ_related_product) { create(:product) }
  given(:product_image) { build(:image) }
  given(:related_image) { build(:image) }

  background do
    product.images << product_image
    related_product.images << related_image
    visit potepan_product_path(product.id)
  end

  scenario '商品詳細ページで商品名、価格、商品内容の表示されること' do
    expect(page).to have_title "#{product.name} - BIGBAG Store"
    expect(page).to have_selector '.page-title h2', text: product.name
    expect(page).to have_selector '.active', text: product.name

    expect(page).to have_selector '.media-body h2', text: product.name
    expect(page).to have_selector '.media-body h3', text: product.display_price
    expect(page).to have_selector '.media-body p', text: product.description
  end

  scenario '一覧ページへ戻るをクリックしたら、その商品のカテゴリーページへ移動されること' do
    click_on '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end

  scenario "関連商品が表示される" do
    expect(page).to have_selector 'h5', text: related_product.name
    expect(page).to have_selector 'h3', text: related_product.display_price
  end

  scenario '関連商品をクリックしたら商品詳細ページに移動すること' do
    click_on related_product.name
    expect(current_path).to eq potepan_product_path(related_product.id)
  end

  scenario '関連しない商品を表示しないこと' do
    within ".productsContent" do
      expect(page).not_to have_content differ_related_product.name
    end
  end
end
