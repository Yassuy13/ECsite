require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it '商品を選択している場合、タイトルが商品名-BIGBAG Storeと表示' do
    expect(full_title('page-title')).to eq 'page-title - BIGBAG Store'
  end

  it '商品を選択していない場合、タイトルがBIGBAG Storeのみ表示' do
    expect(full_title(nil)).to eq 'BIGBAG Store'
  end

  it '商品を選択していない場合、タイトルがBIGBAG Storeのみ表示' do
    expect(full_title('')).to eq 'BIGBAG Store'
  end
end
