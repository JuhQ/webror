class PlacesController < ApplicationController
  def index
  end

  def show
    @place = session["places-#{params[:id]}"]
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @places.each do |place|
        session["places-#{place.id}"] = place
      end

      render :index
    end
  end
end
