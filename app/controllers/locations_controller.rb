class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    locationData = JSON.parse(params.except(:controller, :action).keys.first)
    @location = Location.new
    
    @location.name = locationData['name']
    @location.description = locationData['description']
    @location.address = locationData['address']
    @location.loc[0] = locationData['loc']['latitude']
    @location.loc[1] = locationData['loc']['longitude']
    @location.feature24hr = locationData['feature24hr']
    @location.featureSeating = locationData['featureSeating']
    @location.featurePower = locationData['featurePower']

    @location.save
    render json: @location
  end
 
  def update
    # ERROR here - fails to parse when the module hits my :loc definition (it's an array).
    #  What gives, man? :-(
    locationData = JSON.parse(params.except(:controller, :action).keys.first)
    @location = Location.find(params[:id])
    @location.name = locationData['name']
    @location.description = locationData['description']
    @location.address = locationData['address']
    @location.loc[0] = locationData['loc'][0]
    @location.loc[1] = locationData['loc'][1]
    @location.feature24hr = locationData['feature24hr']
    @location.featureSeating = locationData['featureSeating']
    @location.featurePower = locationData['featurePower']

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
