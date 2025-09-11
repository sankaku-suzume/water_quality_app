class ResultsController < ApplicationController
  before_action :set_sample, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_test_items, only: [ :new, :create, :edit, :update, :destroy ]

  def new
    @result = @sample.results.build
  end

  def create
    @result = @sample.results.build(result_params)
    if @result.save
      flash.now.notice = '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @result = Result.find(params[:id])
  end

  def update
    @result = Result.find(params[:id])
    if @result.update(result_params)
      flash.now.notice = '変更しました'
    else
      flash.now[:error] = '変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    result = Result.find(params[:id])
    result.destroy!
    redirect_to plant_sample_path(@sample.plant, @sample), notice: '削除しました'
  end

  private
  def result_params
    params.require(:result).permit(:value, :test_item_id)
  end

  def set_sample
    @sample = Sample.find(params[:sample_id])
  end

  def set_test_items
    @test_items = TestItem.all
  end
end
