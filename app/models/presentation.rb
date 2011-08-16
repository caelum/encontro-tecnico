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
      user = User.find_by_name(values[1])
      presentations << Presentation.create!(name: values[2], description: values[3], user: user)
    }
    presentations
  end

  def accept!
    self.scheduled_date = suggested_date
    self.save!
  end

  def suggest_date!
    date = Presentation.select(:scheduled_date).where("scheduled_date is not null").order(:scheduled_date).limit(1).first
    date = Time.now if date.nil?
    self.suggested_date = (date + 1.week).monday
    save!
    self
  end

end
