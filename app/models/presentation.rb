class Presentation < ActiveRecord::Base
  belongs_to :user

  after_create :add_last_presentation_to_user
  before_update :update_last_presentation_to_user

  def update_last_presentation_to_user
    old = Presentation.find(self.id)
    if(old.scheduled_date != self.scheduled_date || old.suggested_date != self.suggested_date)
      self.user.update_attribute :last_presentation,  self
    end
  end

  def add_last_presentation_to_user
    if(self.user)
      self.user.update_attribute :last_presentation,  self
    end
  end

end
