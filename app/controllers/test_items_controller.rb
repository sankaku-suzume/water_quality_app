class TestItemsController < ApplicationController

  def index
    @test_items = TestItem.all.order('sort_order')
  end

  def new
    @test_item = TestItem.build
  end

  def create
    @test_item = TestItem.build(test_item_params)
    if @test_item.save
      redirect_to test_items_path, notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def test_item_params
    params.require(:test_item).permit(:name, :unit, :detection_limit, :standard_max, :standard_min, :sort_order)
  end

end