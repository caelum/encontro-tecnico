require 'spec_helper'

describe Presentation do
  context "Last scheduled date" do

    it "should return the date of the last scheduled presentation" do
      monday = Time.now.to_date.monday

      Factory('scheduled_presentation', scheduled_date: monday - 1.week)
      Factory('scheduled_presentation', scheduled_date: monday)
      Factory('scheduled_presentation', scheduled_date: monday + 1.week)

      last_scheduled = Factory('scheduled_presentation', scheduled_date: monday + 2.weeks)

      Factory('suggested_presentation', suggested_date: monday + 3.weeks)
      Factory('suggested_presentation', suggested_date: monday + 4.weeks)

      Presentation.last_scheduled_date.should == last_scheduled.scheduled_date
    end

    it "should return next monday from now if there is no scheduled presentations" do
      today = Time.now.to_date

      last_date = Presentation.last_scheduled_date
      last_date.should == today.monday
    end
  end

  context "suggest_date" do
    it "should suggest next monday and update the preentation" do
      date = Time.now.monday.to_date
      p = Factory('presentation')
      Presentation.should_receive(:last_scheduled_date).and_return(date)

      p.suggested_date.should be_nil
      p.suggest_date!
      p.suggested_date.should == (date + 1.week)

    end
  end
end
