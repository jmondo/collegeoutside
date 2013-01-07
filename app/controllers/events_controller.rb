class EventsController < ApplicationController
  helper_method :wanted_items

  def index
  end

  protected

  def wanted_items
    @wanted_items ||= WantedItem.all
  end
end
