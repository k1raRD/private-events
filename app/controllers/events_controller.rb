class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to events_path, notice: 'event is being updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def attend
    @event = Event.find(params[:id])
    current_user.attended_events << @event
    redirect_to @event, notice: 'you are now attending this event'
  end

  def unattend
    @event = Event.find(params[:id])
    current_user.attended_events.delete(@event)
    redirect_to @event, notice: 'you have successfully unattended this event'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end
end
