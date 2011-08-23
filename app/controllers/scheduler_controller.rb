class SchedulerController < ApplicationController

  def index
    @presentation = Presentation.scheduled
  end
end
