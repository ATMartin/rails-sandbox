class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
   
  def new
    locationData = JSON.parse(params.except(:controller, :action).keys.first)
    @location = Location.new
    @location.description = locationData['description']
    @location.name = locationData['name']
    @location.loc[0] = locationData['loc']['latitude']
    @location.loc[1] = locationData['loc']['longitude']

    @location.save
    render :json => @location 
  end

  def create
    @location = Location.new(location_params)

    @location.features.push("24hr") if (params[:location][:feature24hr] == '1')
    @location.features.push("power") if (params[:location][:featurePower] == '1')
    @location.features.push("seating") if (params[:location][:featureSeating] == '1')
   
    @location.loc[0] = params[:loc[0]]
    @location.loc[1] = params[:loc[1]]
    @location.save
    render json: @location
  end
  
  def show
    @location = Location.where(name: params[:id]).take
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
