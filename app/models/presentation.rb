class Presentation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validates_associated :user

  after_create :add_last_presentation_to_user
  before_update :update_last_presentation_to_user

  def update_last_presentation_to_user
    old = Presentation.find(self.id)
    if(old.scheduled_date != self.scheduled_date || old.suggested_date != self.suggested_date)
      self.user.update_attribute :last_presentation,  self
    end
  end

  def add_last_presentation_to_user
    if(!self.user.nil?)
      self.user.last_presentation = self;
      self.user.save!
    end
  end

  def self.from_user(user)
    Presentation.where(user_id: user)
  end


  def self.from_tsv
    presentations = []
    lines = File.new("presentations.tsv").readlines()
    lines.shift
    lines.each { |line|
      values = line.split("\t")
      presentations << Presentation.new(name: values[2], description: values[3])
    }
    presentations
  end

end
