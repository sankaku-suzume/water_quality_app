class TestItemsController < ApplicationController

  def index
    @test_items = TestItem.all.order('sort_order')
  end

end