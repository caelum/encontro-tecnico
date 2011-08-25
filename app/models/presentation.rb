class Presentation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validates_associated :user

  after_create :add_last_presentation_to_user
  before_update :update_last_presentation_to_user

  def update_last_presentation_to_user
    old = Presentation.find(self.id)
    if (old.scheduled_date != self.scheduled_date || old.suggested_date != self.suggested_date)
      self.user.update_attribute :last_presentation, self
    end
  end

  def add_last_presentation_to_user
    if (!self.user.nil?)
      self.user.last_presentation = self;
      self.user.save!
    end
  end

  class << self
    def from_user(user)
      Presentation.where(user_id: user)
    end


    def from_tsv
      presentations = []
      lines = File.new("presentations.tsv").readlines()
      lines.each { |line|
        values = line.split("\t")
        user = User.find_by_name(values[1])
        presentations << Presentation.create!(name: values[2], description: values[3], user: user)
      }
      presentations
    end

    def last_scheduled_date
      result = Presentation.select(:scheduled_date).where("scheduled_date is not null").order("scheduled_date DESC").limit(1)

      if result.any?
        result.first[:scheduled_date]
      else
        Time.now.to_date.monday
      end
    end


    def scheduled
      Presentation.where("scheduled_date is not null and scheduled_date > ?", Time.now).order(:scheduled_date)
    end

    def all_by_dates
      Presentation.order("scheduled_date DESC, suggested_date DESC, created_at DESC")
    end

  end


  def accept!
    self.scheduled_date = suggested_date
    self.suggestion_rejected = false
    self.save!
  end

  def suggest_date!
    date = Presentation.last_scheduled_date

    self.suggested_date = (date + 1.week).monday
    save!
    self
  end

  def reject!
    self.suggestion_rejected = true
    self.save!
  end


  def can_be_edited_by(user)
    self.user == user || (user && user.admin?)
  end

  def scheduled?
    scheduled_date != nil
  end

  def suggested?
    suggested_date != nil && !suggestion_rejected?
  end

end
