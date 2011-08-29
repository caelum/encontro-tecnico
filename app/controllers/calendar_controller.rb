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

      daylight do
        timezone_offset_from "-0300"
        timezone_offset_to "-0300"
        timezone_name "BRT"
        add_recurrence_rule "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
      end

      standard do
        timezone_offset_from "-0300"
        timezone_offset_to "-0300"
        timezone_name "BRT"
        add_recurrence_rule "YEARLY;BYMONTH=11;BYDAY=1SU"
      end
    end


    @calendar.publish
    @calendar.to_ical
    render :layout => false, :text => @calendar.to_ical

  end
end
