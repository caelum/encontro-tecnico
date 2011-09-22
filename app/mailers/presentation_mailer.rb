# encoding: UTF-8
class PresentationMailer < ActionMailer::Base
  default from: "david.paniz@caelum.com.br"


  def suggest_date_to(presentation)
    @presentation = presentation
    mail(to: [presentation.user.email], subject: "[Almoço Técnico] - Pode apresentar #{presentation.name} em #{presentation.suggested_date}")
  end

  def notify_user(user, presentation)
    @presentation = presentation
    @user = user
    mail(to: [user.email], subject: "[Almoço Técnico] - Veja #{presentation.name} com #{presentation.user.name} na próxima segunda")
  end

  def notify_speaker(presentation)
    @presentation = presentation
    mail(to: [presentation.user.email], subject: "[Almoço Técnico] - Lembrete de apresentação na próxima segunda")
  end

end
