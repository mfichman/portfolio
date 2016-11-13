require 'test_helper'

class AssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset = assets(:one)
  end

  test "should get index" do
    get assets_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_url
    assert_response :success
  end

  test "should create asset" do
    assert_difference('Asset.count') do
      post assets_url, params: { asset: { asset_class: @asset.asset_class, expense_ratio: @asset.expense_ratio, market_cap: @asset.market_cap, name: @asset.name, style: @asset.style, symbol: @asset.symbol } }
    end

    assert_redirected_to asset_url(Asset.last)
  end

  test "should show asset" do
    get asset_url(@asset)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_url(@asset)
    assert_response :success
  end

  test "should update asset" do
    patch asset_url(@asset), params: { asset: { asset_class: @asset.asset_class, expense_ratio: @asset.expense_ratio, market_cap: @asset.market_cap, name: @asset.name, style: @asset.style, symbol: @asset.symbol } }
    assert_redirected_to asset_url(@asset)
  end

  test "should destroy asset" do
    assert_difference('Asset.count', -1) do
      delete asset_url(@asset)
    end

    assert_redirected_to assets_url
  end
end
