require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it '商品を選択している場合、タイトルが商品名-BIGBAGと表示' do
    expect(full_title("page-title")).to eq "page-title - BIGBAG"
  end

  it '商品を選択していない場合、タイトルがBIGBAGのみ表示' do
    expect(full_title(nil)).to eq "BIGBAG"
  end
end
