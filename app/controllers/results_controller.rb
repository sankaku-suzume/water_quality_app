class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sample, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_test_items, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_result, only: [ :show, :destroy ]
  before_action :result_approved?, only: [ :edit, :update ]

  def show
    @recent_results = Result.joins(:sample).where(test_item_id: @result.test_item_id, sample: { plant_id: @result.sample.plant_id }).order(sampling_date: :desc).limit(20)
    label = @recent_results.pluck('sample.sampling_date').reverse
    data = @recent_results.pluck(:value).reverse
    @chart_data = {
      labels: label,
      datasets: [ {
        label: @result.test_item.name,
        backgroundColor: '#3B82F6',
        borderColor: '#3B82F6',
        data: data.map(&:to_f)
      } ]
    }
    @chart_options = {
      scales: {
        yAxes: [ {
          ticks: {
            beginAtZero: true
          }
        } ]
      }
    }
  end
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
    # @result = Result.find(params[:id])
  end

  def update
    # @result = Result.find(params[:id])
    if @result.update(result_params)
      flash.now.notice = '変更しました'
    else
      flash.now[:error] = '変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @result.destroy!
    flash.now.notice = '削除しました'
  end

  private
  def result_params
    params.require(:result).permit(:value, :test_item_id)
  end

  def set_sample
    @sample = Sample.find(params[:sample_id])
  end

  def set_test_items
    @test_items = TestItem.all.order(:sort_order)
  end

  def set_result
    @result = Result.find(params[:id])
  end

  def result_approved?
    set_result
    if @result.approved?
      redirect_to plant_sample_path(params[:plant_id], params[:sample_id]),  notice: '承認済みの結果は編集できません'
    end
  end
end
