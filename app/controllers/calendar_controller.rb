class CalendarController < ApplicationController
  def index
    @calendar = Icalendar::Calendar.new

        Presentation.scheduled.each do |presentation|
          event = Icalendar::Event.new
          date = presentation.scheduled_date
          event.start = DateTime.civil(date.year, date.month, date.day, 13)
          event.end = DateTime.civil(date.year, date.month, date.day, 14)
          event.summary = presentation.name
          event.description = presentation.description
          @calendar.add event
        end

        @calendar.publish
        render :layout => false, :text => @calendar.to_ical

  end
end
