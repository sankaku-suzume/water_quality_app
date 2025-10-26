class PlantsController < ApplicationController
  before_action :authenticate_user!
  def index
    plants_sort = Plant.all.order(Arel.sql('name COLLATE "ja-x-icu"'))
    @search = plants_sort.ransack(params[:q])
    @plants = @search.result.all.page(params[:page]).per(25)
  end

  def show
    @plant = Plant.find(params[:id])
    @samples = @plant.samples.order(sampling_date: :desc)
  end

  def new
    @plant = Plant.build
  end

  def create
    @plant = Plant.build(plant_params)
    if @plant.save
      redirect_to plant_path(@plant), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    if @plant.update(plant_params)
      redirect_to plant_path(@plant), notice: '更新できました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    plant = Plant.find(params[:id])
    plant.destroy!
    redirect_to plants_path, status: :see_other, notice: '削除できました'
  end

  private
  def plant_params
    params.require(:plant).permit(:name, :location, :remarks)
  end
end
