require 'spec_helper'

describe Scheduler do
  it "should select the presentation if there is only one" do
    presentation = Factory('presentation')
    suggested_presentation = Scheduler.new.next_suggestion
    suggested_presentation.should == presentation
  end

end
