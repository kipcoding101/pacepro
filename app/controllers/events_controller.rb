# app/controllers/events_controller.rb
class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])

    # 1️⃣ fetch distinct CourseClass values instead of Category
    # 1) Grab distinct CourseClass values via SQL, not via Ruby map
    @course_classes = @event.results
                            .pluck(Arel.sql("DISTINCT raw_data->>'CourseClass'"))
                            .compact
                            .sort
    Rails.logger.debug "👉 available course_classes=#{@course_classes.inspect}"
    # 2️⃣ read the incoming param :course_class (not :category)
    @selected_course_class = params[:course_class]
    Rails.logger.debug "👉 selected_course_class=#{@selected_course_class.inspect}"

    # 3) Build an ActiveRecord relation, and apply a WHERE filter if needed
    scope = @event.results
    if @selected_course_class.present?
      scope = scope.where(
        "raw_data ->> 'CourseClass' = ?",
        @selected_course_class
      )
    end

    @display_details      = params[:display_details] == "1"
    @display_events       = params[:display_events] == "1"

    # load & order your results
    # 3️⃣ filter by CourseClass if one was chosen
    if @selected_course_class.present?
      @results = @results.select do |r|
        Rails.logger.debug "🗝️ comparing #{r["CourseClass"].inspect} == #{@selected_course_class.inspect}"
        r["CourseClass"].strip == @selected_course_class
      end
      Rails.logger.debug "👉 filtered results count=#{@results.size}"
    end

    # 1️⃣ add this block for live search on Name
    if params[:search_query].present?
      pattern = "%#{params[:search_query]}%"
      scope = scope.where(
        "raw_data ->> 'Name (Free Format)' ILIKE ?",
        pattern
        )
      end

      @results = scope.order(
            Arel.sql("raw_data ->> 'CourseClass' ASC"),
            Arel.sql("(raw_data ->> 'Position')::int ASC")
            )

  end
end
