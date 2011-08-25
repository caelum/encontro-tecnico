require "spec_helper"

describe PresentationMailer do
  context "Suggestion date mailer" do
    let(:presentation) { Factory('suggested_presentation') }
    let(:mail) { PresentationMailer.suggest_date_to(presentation) }


    it "should send date and title to the owner of the talk approve the suggested date" do
      mail.to.should == [presentation.user.email]
      mail.body.encoded.should match(presentation.user.name)
      mail.body.encoded.should match(presentation.name)
      mail.body.encoded.should match(presentation.suggested_date.to_s)

      mail.body.encoded.should match("http://localhost:3000" + presentation_accept_suggestion_path(presentation))
      mail.body.encoded.should match("http://localhost:3000" + presentation_reject_suggestion_path(presentation))

    end

  end

end

