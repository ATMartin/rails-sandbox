require 'twilio-ruby'

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
  
  def share_sms
    Twilio.configure do |config|
      config.account_sid = 'AC5ea618dacee0512f771ca416a4072000' 
      config.auth_token = '295c76eb5afad2daa90e4912d8bfd26f'
    end
   
    begin
      @client = Twilio::REST::Client.new
      @client.messages.create({
        from: '+18033888119',
        to: params['recNumber'],
        body: params['messageBody'] 
      })
      render json: { "type" => "Success", "message" => "SMS successfully sent!"}
    rescue Twilio::REST::RequestError => e
      render json: { "type" => "Error", "message" => "ERROR - #{e.message}"}
    end
    
  end
  
  def share_email
    render :json => {"message" => "ALL YOUR MAILZ ARE BELONG TO US"} 
  end 

  private
    def location_params
      params.require(:location).permit(:name, :description, :address, :features, :loc) 
    end

end
