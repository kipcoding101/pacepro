class PagesController < ApplicationController
  def home
  end

  def homely
  end

  def about
  end

  def services
  end

  def events
    @events = Event.all
  end
end
