class CalendarController < ApplicationController
  def index
    @calendar = Icalendar::Calendar.new

    Presentation.scheduled.each do |presentation|
      event = Icalendar::Event.new
      date = presentation.scheduled_date
      event.start = DateTime.civil(date.year, date.month, date.day, 13, 0, 0, -3).utc
      event.end = DateTime.civil(date.year, date.month, date.day, 14, 0, 0, -3).utc
      event.summary = "#{presentation.user.name} - #{presentation.name}"
      event.description = presentation.description
      @calendar.add event
    end


    @calendar.timezone do
      timezone_id "America/Sao_Paulo"
    end


    @calendar.publish
    render :layout => false, :text => @calendar.to_ical

  end
end
