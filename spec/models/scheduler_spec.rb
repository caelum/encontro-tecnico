require 'spec_helper'

describe Scheduler do
  it "should select the presentation if there is only one" do
    presentation = Factory('presentation')

    suggested_presentation = Scheduler.new.next_suggestion
    suggested_presentation.should == presentation
  end

  it "should select first not scheduled presentation from the selected user" do
    user1 = Factory(:user)
    user2 = Factory(:user)

    presentation_from_user_1 = Factory('presentation', user: user2)
    suggested_presentation_from_user_1 = Factory('scheduled_presentation', user: user1, suggested_date: 2.weeks.ago)
    presentation_from_user_1 = Factory('presentation', user: user1)
    presentation2_from_user_1 = Factory('presentation', user: user1)

    User.should_receive(:next_suggestion).and_return(user1)

    suggested_presentation = Scheduler.new.next_suggestion
    suggested_presentation.should == presentation_from_user_1
  end
end
