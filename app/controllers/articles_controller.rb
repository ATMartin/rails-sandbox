class ArticlesController < ApplicationController
 
  skip_before_action :verify_authenticity_token  
  
  def new
    # @location = { :name => "WalMart", :description => "Nice place, dark parking lot.", :features => ['24hr', 'power', 'seating'], :loc => {:lat => "-34", :long => "82"}}
    # render json: @location
    
  end

  def create
    print params
    render plain: params[:article].inspect
  end

  def echo
    print params
    render json: params
  end
end
