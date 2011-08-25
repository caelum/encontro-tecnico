# encoding: UTF-8
class PresentationMailer < ActionMailer::Base
  default from: "david.paniz@caelum.com.br"


  def suggest_date_to(presentation)
    @presentation = presentation
    mail(to: [presentation.user.email], subject: "[Almoço Técnico] - Pode apresentar #{presentation.name} em #{presentation.suggested_date}")
  end
end
