require 'spec_helper'

describe Scheduler do
  it "should select the presentation if there is only one" do
    presentation = Factory('presentation')
    suggested_presentation = Scheduler.new.next_suggestion
    suggested_presentation.should == presentation
  end

  it "should select the presentation from the user who has given a talk least recently" do
    user1 = Factory(:user)
    Factory('presentation')
    Factory('presentation')
    Factory('presentation')
    Factory('presentation')
    Factory('presentation')
    presentation_from_user_1 = Factory('presentation', user: user1)

    User.should_receive(:next_suggestion).and_return(user1)

    suggested_presentation = Scheduler.new.next_suggestion
    suggested_presentation.should == presentation_from_user_1
  end
end
