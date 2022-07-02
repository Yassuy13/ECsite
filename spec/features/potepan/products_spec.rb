# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Potepan::Products', type: :feature do
  given(:taxon) { create(:taxon, taxonomy: taxonomy) }
  given(:taxonomy) { create(:taxonomy) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { build(:image) }

  background do
    product.images << image
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
end
