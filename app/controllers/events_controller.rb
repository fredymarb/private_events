class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:notice] = "Event created successfully."
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Failed to create event."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.expect(event: [ :name, :date ])
  end
end
