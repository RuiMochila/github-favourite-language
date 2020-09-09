class PagesController < ApplicationController

  def home
  end

  def languages
    GuessFavouriteLanguageJob.perform_later(params[:username])
  end

end
