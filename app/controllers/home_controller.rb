class HomeController < ApplicationController
  def index
    @countries = Country.all
    @current_date = Date.today
    # If today is Sunday then it's a new week. Otherwise we are still in the middle of the last week.
    @current_week_start =  (@current_date.wday == 0 ? @current_date :  @current_date - @current_date.wday)
    @country_this_week = Country.find_by_date_started(@current_week_start)

    if (@country_this_week == nil)
      # We need a new country. Let's see what we've got left.
      @remaining_countries = Country.find_all_by_date_started(nil)

      if (@remaining_countries.count == 0)
        # Uh oh, we used up all the countries. Better reset and start again.
        Country.all.each do |country|
           country.update_attribute(:date_started, nil)
        end
      end

      new_country = Country.first(:conditions => {:date_started =>nil}, :offset => rand(@remaining_countries.count))
      new_country.update_attribute(:date_started, @current_week_start)
      @country_this_week = new_country

    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end

end
