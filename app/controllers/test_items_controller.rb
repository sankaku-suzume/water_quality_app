class TestItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @test_items = TestItem.all.order('sort_order')
  end

  def new
    @test_item = TestItem.build
  end

  def create
    @test_item = TestItem.build(test_item_params)
    if @test_item.save
      flash.now.notice = '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @test_item = TestItem.find(params[:id])
  end

  def update
    @test_item = TestItem.find(params[:id])
    if @test_item.update(test_item_params)
      flash.now.notice = '更新しました'
    else
      flash.now[:error] = '変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    test_item = TestItem.find(params[:id])
    test_item.destroy!
    redirect_to test_items_path, status: :see_other, notice: '削除しました'
  end

  private
  def test_item_params
    params.require(:test_item).permit(:name, :unit, :detection_limit, :standard_max, :standard_min, :sort_order)
  end
end
