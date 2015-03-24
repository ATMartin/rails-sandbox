class ArticlesController < ApplicationController
 
  skip_before_action :verify_authenticity_token  
  
  def new
    # @location = { :name => "WalMart", :description => "Nice place, dark parking lot.", :features => ['24hr', 'power', 'seating'], :loc => {:lat => "-34", :long => "82"}}
    # render json: @location
    
  end

  def create
    @article = Article.new(article_params)

    @article.save
    render json: @article
    #redirect_to @article
  end

  def echo
    print params
    render json: params
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
