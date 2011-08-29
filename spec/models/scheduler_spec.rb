require 'spec_helper'

describe Scheduler do
  it "should select the presentation if there is only one" do
    presentation = Factory('presentation')

    suggested_presentation = Scheduler.next_suggestion
    suggested_presentation.should == presentation
  end

  it "should select first not scheduled presentation from the selected user" do
    user2 = Factory(:user)
    presentation_from_user_2 = Factory('presentation', user: user2)

    user1 = Factory(:user)
    already_suggested_presentation_from_user_1 = Factory('scheduled_presentation', user: user1, suggested_date: 2.weeks.ago)
    first_from_user_1 = Factory('presentation', user: user1)
    second_from_user_1 = Factory('presentation', user: user1)

    User.should_receive(:next_suggestion).and_return(user1)

    suggested_presentation = Scheduler.next_suggestion
    suggested_presentation.should == first_from_user_1
  end

  it "should consider presentation with rejected date as a unsuggested presentation on next week" do
    user1 = Factory(:user)

    already_suggested_but_rejected_presentation_from_user_1 = Factory('scheduled_and_rejected_presentation', user: user1, suggested_date: 2.weeks.ago)
    presentation_from_user_1 = Factory('presentation', user: user1)

    User.should_receive(:next_suggestion).and_return(user1)


    suggested_presentation = Scheduler.next_suggestion
    suggested_presentation.should == already_suggested_but_rejected_presentation_from_user_1
  end

  it "should return nil if there is no user available" do
    User.should_receive(:next_suggestion).and_return(nil)

    suggested_presentation = Scheduler.next_suggestion
    suggested_presentation.should be_nil
  end
  context "can execute" do
    context "should return false if there is a suggested presentation neither approved nor rejected" do
      it "try after rejected" do
        p = Factory('suggested_presentation', suggested_date: 2.weeks.ago)
        Factory('presentation')

        Scheduler.can_execute?.should be_false
        p.reject!
        Scheduler.can_execute?.should be_true
      end

      it "try after accept" do
        p = Factory('suggested_presentation', suggested_date: 2.weeks.ago)
        Factory('presentation')

        Scheduler.can_execute?.should be_false
        p.accept!
        Scheduler.can_execute?.should be_true
      end

      it "should return true if there is NO scheduled presentations" do
        Factory('presentation')
        Factory('presentation')

        Scheduler.can_execute?.should be_true
      end
    end

    context "should return false if there are scheduled presentations until 1 months from now" do
      it "should return true if the last scheduled presentation is before 4 weeks from now" do
        Factory('scheduled_presentation', scheduled_date: 1.weeks.from_now)
        Factory('scheduled_presentation', scheduled_date: 2.weeks.from_now)
        Factory('presentation')

        Scheduler.can_execute?.should be_true
      end

      it "should return false if the last scheduled presentation is after 4 weeks from now" do
        Factory('scheduled_presentation', scheduled_date: 3.weeks.from_now)
        Factory('scheduled_presentation', scheduled_date: 4.weeks.from_now)
        Factory('scheduled_presentation', scheduled_date: 5.weeks.from_now)
        Factory('presentation')

        Scheduler.can_execute?.should be_false
      end
    end
  end
end
