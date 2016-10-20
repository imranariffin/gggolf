class HomeController < ApplicationController
  def index
  	@tournaments = Tournament.all
  end
  def about
  end
end
