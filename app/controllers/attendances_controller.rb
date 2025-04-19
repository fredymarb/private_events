class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    Attendance.create!(attendee: current_user, attended_event: event)

    flash[:notice] = "You have been added to this event"
    redirect_to event_path(event)
  end

  def destroy
    event = Event.find(params[:id])
    attendance = Attendance.find_by(attendee: current_user, attended_event: event)
    attendance.destroy

    flash[:notice] = "You have been removed from this event"
    redirect_to event_path(event)
  end
end
