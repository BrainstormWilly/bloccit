class AdvertisementsController < ApplicationController
  def index
    @ads = Advertisement.all
  end

  def show
    @ad = Advertisement.find(params[:id])
  end

  def new
    @ad = Advertisement.new
  end

  def create
    @ad = Advertisement.new
    @ad.title = params[:advertisement][:title]
    @ad.body = params[:advertisement][:body]
    @ad.price = params[:advertisement][:price]

    if @ad.save
      flash[:notice] = 'Ad was saved successfully'
      redirect_to @ad
    else
      flash.now[:alert] = 'There was an error saving the ad. Please try again later.'
      render :new
    end
  end
end
