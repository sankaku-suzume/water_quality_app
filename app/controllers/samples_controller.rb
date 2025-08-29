class SamplesController < ApplicationController
  before_action :set_plant, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @samples = Sample.all.order(sampling_date: :desc)
  end

  def show
    @sample = @plant.samples.find(params[:id])
  end

  def new
    @sample = @plant.samples.build
  end

  def create
    @sample = @plant.samples.build(sample_params)
    if @sample.save
      redirect_to plant_sample_path(@plant, @sample), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
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
    
  end

  private
  def sample_params
    params.require(:sample).permit(:sampling_date, :sampling_time, :location, :inspector, :remarks )
  end

  def set_plant
    @plant = Plant.find(params[:plant_id])
  end

end