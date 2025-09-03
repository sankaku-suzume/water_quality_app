class ResultsController < ApplicationController
  before_action :set_sample, only: [ :new, :create ]

  def new
    @test_items = TestItem.all
    @result = @sample.results.build
  end

  def create
    @test_items = TestItem.all
    @result = @sample.results.build(result_params)
    if @result.save
      redirect_to plant_sample_path(@sample.plant, @sample), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def result_params
    params.require(:result).permit(:value, :test_item_id)
  end

  def set_sample
    @sample = Sample.find(params[:sample_id])
  end
end
