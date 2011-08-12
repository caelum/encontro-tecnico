class PresentationsController < ApplicationController
  before_filter :logged_user

  def index
    @presentations = Presentation.from_user(current_user)
    puts @presentations.any?
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new params[:presentation]
    @presentation.user = current_user
    @presentation.save!
    redirect_to action: :index
  end
end
