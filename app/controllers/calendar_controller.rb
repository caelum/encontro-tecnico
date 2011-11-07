class CalendarController < ApplicationController
  def index
    @calendar = Icalendar::Calendar.new

    Presentation.scheduled.each do |presentation|
      event = Icalendar::Event.new
      date = presentation.scheduled_date
      brazilTimezone = Time.zone.formatted_offset
      event.start = DateTime.civil(date.year, date.month, date.day, 13, 0, 0, brazilTimezone)
      event.end = DateTime.civil(date.year, date.month, date.day, 14, 0, 0, brazilTimezone)
      event.summary = "#{presentation.user.name} - #{presentation.name}"
      event.description = presentation.description
      @calendar.add event
    end

    @calendar.publish
    render :layout => false, :text => @calendar.to_ical

  end
end
