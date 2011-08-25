# encoding: UTF-8
class PresentationsController < ApplicationController
  before_filter :filter_only_logged_user

  def index
    if(current_user.admin?)
      @presentations = Presentation.all_by_dates
    else
      redirect_to action: :mine
    end
  end

  def mine
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
    redirect_to action: :mine
  end

  def accept
    @presentation = Presentation.find(params[:presentation_id])
    if(@presentation.can_be_edited_by(current_user))
      @presentation.accept!
      flash[:error] = "Data aceita"
    else
      flash[:error] = "Você não pode editar uma apresentação alheia"
    end
    redirect_to presentations_path
  end

  def reject
    @presentation = Presentation.find(params[:presentation_id])
    if(@presentation.can_be_edited_by(current_user))
      @presentation.reject!
      flash[:error] = "Data rejeitada"
    else
      flash[:error] = "Você não pode editar uma apresentação alheia"
    end
    redirect_to presentations_path
  end
end
