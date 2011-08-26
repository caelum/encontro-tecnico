# encoding: UTF-8
class PresentationsController < ApplicationController
  before_filter :filter_only_logged_user

  before_filter :security_check, only: [:edit, :update, :accept, :reject]

  def index
    if (current_user.admin?)
      @presentations = Presentation.all_by_dates
    else
      redirect_to action: :mine
    end
  end

  def mine
    @presentations = Presentation.from_user(current_user)
  end

  def form
    @presentation = Presentation.new
    render 'form'
  end

  def edit
    render 'form'
  end

  def update
    @presentation.update_attributes params[:presentation]
    flash[:error] = "Atualizado com sucesso"
    redirect_to presentations_path
  end

  def create
    @presentation = Presentation.new params[:presentation]
    @presentation.user = current_user
    @presentation.save!
    redirect_to action: :mine
  end

  def accept
    @presentation.accept!
    flash[:error] = "Data aceita"
    redirect_to presentations_path
  end

  def reject
    @presentation.reject!
    flash[:error] = "Data rejeitada"
    redirect_to presentations_path
  end

  def suggest
    if (current_user.admin?)
      @presentation = Presentation.find(params[:presentation_id])
      @presentation.suggest_date!
      flash[:error] = "Data sugerida"
    else
      flash[:error] = "Você não pode sugerir datas"
    end
    redirect_to presentations_path
  end

  private
  def security_check
    id = params[:presentation_id]
    id ||= params[:id]
    @presentation = Presentation.find(id)
    unless (@presentation.can_be_edited_by(current_user))
      flash[:error] = "Você não pode editar uma apresentação alheia"
      redirect_to presentations_path
    end
  end
end
