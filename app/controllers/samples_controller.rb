class SamplesController < ApplicationController
  before_action :set_plant, only: [ :show, :new, :create, :edit, :update, :destroy ]

  def index
    @samples = Sample.all.order(sampling_date: :desc)
  end

  def show
    @sample = @plant.samples.find(params[:id])
    @results = @sample.results.joins(:test_item).order('sort_order')
  end

  def new
    if @plant
      @sample = @plant.samples.build
    else
      @sample = Sample.build
      @plants = Plant.all.order(Arel.sql('name COLLATE "japanese"'))
    end
  end

  def create
    if @plant
      @sample = @plant.samples.build(sample_params)
      if @sample.save
        redirect_to plant_sample_path(@plant, @sample), notice: '保存しました'
      else
        flash.now[:error] = '保存に失敗しました'
        render :new, status: :unprocessable_entity
      end
    else
      @sample = Sample.build(sample_params)
      if @sample.save
        redirect_to plant_sample_path(@sample.plant, @sample), notice: '保存しました'
      else
        flash.now[:error] = '保存に失敗しました'
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @sample = @plant.samples.find(params[:id])
  end

  def update
    @sample = @plant.samples.find(params[:id])
    if @sample.update(sample_params)
      redirect_to plant_sample_path(@plant, @sample), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    sample = @plant.samples.find(params[:id])
    sample.destroy!
    redirect_to plant_path(@plant), status: :see_other, notice: '削除しました'
  end

  private
  def sample_params
    params.require(:sample).permit(:plant_id, :sampling_date, :sampling_time, :location, :inspector, :remarks)
  end

  def set_plant
    @plant = Plant.find(params[:plant_id]) if params[:plant_id]
  end
end
