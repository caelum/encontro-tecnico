# encoding: UTF-8
class CaelumMailer < ActionMailer::Base
  default from: "david.paniz@caelum.com.br", to: "luiz.bassi@caelum.com.br"


  def notify_lunch
    mail(subject: "[Lembrete Almoço Técnico] - Pagar almoço")
  end


  def notify_sandwich
    mail(subject: "[Lembrete Almoço Técnico] - Pedir lanche")
  end

end
