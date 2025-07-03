class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = Event.order(date: :desc)
  end

  def show
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
      :date,
      :location,
      :description,
      :google_form_url,
      :result_published,
      :title,
      :cover_image,
      gallery_images: []
    )
  end
end
