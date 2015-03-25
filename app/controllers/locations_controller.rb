class LocationsController < ApplicationController
  
  def new
  
  end

  def create
    @location = Location.new(location_params)

    @location.features.push("24hr") if (params[:location][:feature24hr] == '1')
    @location.features.push("power") if (params[:location][:featurePower] == '1')
    @location.features.push("seating") if (params[:location][:featureSeating] == '1')
    
    @location.save
    render json: @location
  end
  
  def show
    @location = Location.find(params[:id])
    render json: @location
  end
  
  def index
    @locations = Location.all
    render json: @locations
  end
  
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    redirect_to locations_path
  end 

  private
    def location_params
      params.require(:location).permit(:name, :description, :address, :features, :loc) 
    end

end
