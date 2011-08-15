# encoding: UTF-8
class PresentationMailer < ActionMailer::Base
  default from: "from@example.com"


  def suggest_date_to(presentation)
    @presentation = presentation
    mail(to: [presentation.user.email], subject: "[Almoço Técnico] - Pode apresentar #{presentation.name} em #{presentation.suggested_date}")
  end
end
