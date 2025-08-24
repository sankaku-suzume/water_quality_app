class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find(params[:id])
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

  private
  def plant_params
    params.require(:plant).permit(:name, :location, :remarks)
  end
end
