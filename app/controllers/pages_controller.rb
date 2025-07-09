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

    today = Time.zone.today

    @upcoming_events = Event
                      .where('start_date > ?', today)
                      .order(:start_date)

                      # today < start date

    @live_events = Event
                      .where('start_date <= ? AND end_date >= ?', today, today)
                      .order(:start_date)

                      # today equal or between start date and end date

    @past_events = Event
                      .where('end_date < ?', today)
                      .order(end_date: :desc)


                      # today bigger than end date
  end
end
