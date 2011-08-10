require 'spec_helper'

describe User do
  it "should suggest the user who has given a talk least recently" do
    user1 = Factory(:user)
    user2 = Factory(:user)
    Factory('scheduled_presentation', user: user1)
    Factory('scheduled_presentation', user: user2)


    suggested_user = User.next_suggestion
    suggested_user.should == user1
  end
end
