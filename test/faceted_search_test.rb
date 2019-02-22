require 'test_helper'
require 'byebug'

class FacetedSearch::Test < ActiveSupport::TestCase
  test "all items" do
    @items = Item.all
    assert_equal 6, @items.count
  end

  test "items filtered by 1 facet" do
    @facets = Item::Facets.new({
      kinds: "#{kinds(:kind_1).id}"
    })
    assert_equal 2, @facets.results.count
  end

  test "items filtered by 1 facet and 2 values" do
    @facets = Item::Facets.new({
      kinds: "#{kinds(:kind_1).id},#{kinds(:kind_2).id}"
    })
    assert_equal 3, @facets.results.count
  end

  test "items filtered by 1 facet with a different id" do
    @facets = Item::Facets.new({ products: 'Product 1' })
    assert_equal 2, @facets.results.count
  end

  test "items filtered by 2 facets with results" do
    @facets = Item::Facets.new({
      kinds: "#{kinds(:kind_2).id}",
      categories: "#{categories(:category_1).id}"
    })
    assert_equal 1, @facets.results.count
  end

  test "items filtered by 2 facets with no results" do
    @facets = Item::Facets.new({
      kinds: "#{kinds(:kind_1).id}",
      categories: "#{categories(:category_1).id}"
    })
    assert_equal 0, @facets.results.count
  end

  test "items filtered by 2 facets with multiple values" do
    @facets = Item::Facets.new({
      kinds: "#{kinds(:kind_1).id},#{kinds(:kind_2).id}",
      categories: "#{categories(:category_1).id},#{categories(:category_2).id}"
    })
    assert_equal 1, @facets.results.count
  end

  test "items searched" do
    @facets = Item::Facets.new({
      title: 'Item 1'
    })
    assert_equal 1, @facets.results.count
  end

  test "items searched and filtered with results" do
    @facets = Item::Facets.new({
      title: 'Item 1',
      kinds: "#{kinds(:kind_2).id}"
    })
    assert_equal 1, @facets.results.count
  end

  test "items searched and filtered with no results" do
    @facets = Item::Facets.new({
      title: 'Item 1',
      kinds: "#{kinds(:kind_1).id}"
    })
    assert_equal 0, @facets.results.count
  end
end
