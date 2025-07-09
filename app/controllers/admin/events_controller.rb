class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = Event.order(start_date: :desc)
  end

  def show
    @event             = Event.find(params[:id])
    @categories        = @event.results.map { |r| r["Category"] }.compact.uniq.sort
    @selected_category = params[:category]
    @display_details   = params[:display_details] == "1"
    @display_events    = params[:display_events] == "1"

    @results = @event.results
                    .order(Arel.sql("(raw_data ->> 'Position')::int ASC"))
    if @selected_category.present?
      @results = @results.select { |r| r["Category"] == @selected_category }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_event_path(@event), notice: "Event created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @event = Event.find(params{:id})
  end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Event updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: "Event deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title,
      :location,
      :description,
      :google_form_url,
      :result_published,
      :title,
      :cover_image,
      :start_date,  # added
      :end_date,     # added
      gallery_images: []
    )
  end
end
