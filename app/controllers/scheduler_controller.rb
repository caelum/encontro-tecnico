class SchedulerController < ApplicationController

  def index
    @presentations = Presentation.scheduled
  end
end
