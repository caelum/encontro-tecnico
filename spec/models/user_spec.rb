require 'spec_helper'

describe User do
  it "should order the users by who has given a talk least recently" do
    user3 = Factory(:user)
    user4 = Factory(:user)
    user5 = Factory(:user)
    user6 = Factory(:user)
    user7 = Factory(:user)
    Factory('scheduled_presentation', user: user7, suggested_date: 5.weeks.ago)
    Factory('scheduled_presentation', user: user6, suggested_date: 4.weeks.ago)
    Factory('scheduled_presentation', user: user4, suggested_date: 3.weeks.ago)
    Factory('scheduled_presentation', user: user3, suggested_date: 2.weeks.ago)
    Factory('scheduled_presentation', user: user5, suggested_date: 1.week.ago)


    users = User.sort_users_with_presentation
    users.map{|u| u.email}.should == [user7, user6, user4, user3, user5].map{|u| u.email}
  end

  it "should not show users with presentation not scheduled yet " do
    user3 = Factory(:user)
    user4 = Factory(:user)
    user5 = Factory(:user)
    user6 = Factory(:user)
    user7 = Factory(:user)
    Factory('scheduled_presentation', user: user7, suggested_date: 5.weeks.ago)
    Factory('scheduled_presentation', user: user6, suggested_date: 4.weeks.ago)
    Factory('scheduled_presentation', user: user4, suggested_date: 3.weeks.ago)
    Factory('scheduled_presentation', user: user3, suggested_date: 2.weeks.ago)
    Factory('presentation', user: user5)


    users = User.sort_users_with_presentation
    users.map{|u| u.email}.should == [user7, user6, user4, user3].map{|u| u.email}
  end

  it "should suggest the user who hasn't give a talk yet before others" do
    user1 = Factory(:user)
    user2 = Factory(:user) #does NOT have a talk  (Will not show in result)
    user3 = Factory(:user)
    user4 = Factory(:user)
    user5 = Factory(:user) # has a presentation not scheduled yet

    Factory('scheduled_presentation', user: user3, suggested_date: 5.weeks.ago)
    Factory('scheduled_presentation', user: user1, suggested_date: 4.weeks.ago)
    Factory('scheduled_presentation', user: user4, suggested_date: 3.weeks.ago)

    Factory('presentation', user: user5)


    users = User.without_talk
    users.map{|u| u.email}.should == [user5].map{|u| u.email}
  end


  it "should suggest the user who hasn't give a talk yet before others" do
    user1 = Factory(:user)
    user2 = Factory(:user) #does NOT have a talk  (Will not show in result)
    user3 = Factory(:user)
    user4 = Factory(:user)
    user5 = Factory(:user) # has a presentation not scheduled yet

    Factory('scheduled_presentation', user: user3, suggested_date: 5.weeks.ago)
    Factory('scheduled_presentation', user: user1, suggested_date: 4.weeks.ago)
    Factory('scheduled_presentation', user: user4, suggested_date: 3.weeks.ago)

    Factory('presentation', user: user5)


    users = User.sorted_list
    users.map{|u| u.email}.should == [user5, user3, user1, user4].map{|u| u.email}
  end



  it "should suggest the user who has given a talk least recently" do
    user1 = Factory(:user)
    user2 = Factory(:user)
    Factory('scheduled_presentation', user: user1)
    Factory('scheduled_presentation', user: user2)


    suggested_user = User.next_suggestion
    suggested_user.email.should == user1.email
  end

  it "should bla" do
    presentation = Factory('presentation')
    presentation.user.should == User.next_suggestion

  end

end
