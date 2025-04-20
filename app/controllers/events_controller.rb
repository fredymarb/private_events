class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @user = current_user
    @event = @user.created_events.build
  end

  def create
    @user = current_user
    @event = @user.created_events.build(event_params)

    if @event.save
      flash[:notice] = "Event created successfully."
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Failed to create event."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:notice] = "Event has been deleted."
    redirect_to root_path
  end

  private

  def event_params
    params.expect(event: [ :name, :date ])
  end
end
