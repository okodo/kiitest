class EventsController < ApplicationController

  before_filter :authenticate_user!

  def index
    events = (params[:all].present? ? Event : current_user.events).includes([:user, comments: :user]).all
    respond_with(ActiveModel::ArraySerializer.new(events, each_serializer: EventSerializer))
  end

  def create
    render json: Event.create(filtered_params.merge(user_id: current_user.id)), serializer: EventSerializer
  end

  def update
    event = current_user.events.find(params[:id])
    event.update_attributes(filtered_params)
    render json: event.reload, serializer: EventSerializer
  end

  def destroy
    event = current_user.events.find(params[:id])
    event.destroy
    render nothing: true
  end

  def show
    render json: Event.find(params[:id]), serializer: EventSerializer
  end

  private

  def filtered_params
    params.require(:event).permit(:title, :starts_at, :recurs_on)
  end

end
