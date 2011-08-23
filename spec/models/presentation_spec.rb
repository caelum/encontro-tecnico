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

  context "suggest date" do
    it "should suggest next monday and update the preentation" do
      date = Time.now.monday.to_date
      p = Factory('presentation')

      Presentation.should_receive(:last_scheduled_date).and_return(date)
      p.should_receive(:save!)

      p.suggested_date.should be_nil
      p.suggest_date!
      p.suggested_date.should == (date + 1.week)
      p.scheduled_date.should be_nil
    end
  end

  context "accept date" do
    it "should schedule and update the preentation" do
      date = Time.now.monday.to_date + 1.month
      p = Factory('suggested_presentation', suggested_date: date)

      p.should_receive(:save!)

      p.scheduled_date.should be_nil
      p.accept!
      p.scheduled_date.should == p.suggested_date
      p.suggestion_rejected.should be_false
    end

    it "should set reject as false when a it is approved" do
      date = Time.now.monday.to_date + 1.month
      p = Factory('scheduled_and_rejected_presentation', suggested_date: date)

      p.should_receive(:save!)

      p.scheduled_date.should be_nil
      p.accept!
      p.scheduled_date.should == p.suggested_date
      p.suggestion_rejected.should be_false

    end
  end

  context "reject date" do
    it "should update the preentation as rejected" do
      date = Time.now.monday.to_date + 1.month
      p = Factory('suggested_presentation', suggested_date: date)

      p.should_receive(:save!)

      p.reject!
      p.scheduled_date.should be_nil
      p.suggestion_rejected.should be_true
    end
  end


  context "security" do
    it "should be edited by its owner" do
      p = Factory('presentation')
      p.can_be_edited_by(p.user).should be_true
    end
  end
end
