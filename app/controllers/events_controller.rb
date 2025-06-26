# app/controllers/events_controller.rb
class EventsController < ApplicationController
  def show
    @event   = Event.find(params[:id])
    puts "Ini dia"
    puts "#{@event.id}"
    # Option A: sort in Ruby (fine for small result sets)
    # @results = @event.results.sort_by { |r| r["Position"].to_i }

    # Option B: sort in the database (better for large data)
    @results = @event.results
      .order(Arel.sql("(raw_data ->> 'Position')::int ASC"))
    puts "Results  are displayed here"
    @results.each do |result|
      puts "#{result["RaceNumber"]}"
     end
  end
end
