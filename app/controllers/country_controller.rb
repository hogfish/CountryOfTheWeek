class CountryController < ApplicationController
  def index
    @countries = Country.all


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end
end
