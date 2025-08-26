class SamplesController < ApplicationController

  def index
    @samples = Sample.all.order(sampling_date: :desc)
  end

  def show
    plant = Plant.find(params[:plant_id])
    @sample = plant.samples.find(params[:id])
  end

end