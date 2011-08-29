class Scheduler

  class << self
    def next_suggestion
      next_user = User.next_suggestion
      return nil if next_user.nil?

      presentation = Presentation.where("user_id = ? AND scheduled_date is null AND (suggested_date is null OR suggestion_rejected = ?)", next_user.id, true).order("created_at").first
    end


    def can_execute?
      Presentation.where("scheduled_date is null AND suggested_date is not null AND (suggestion_rejected is null OR suggestion_rejected = ?)", false).count < 1
    end

    def execute
      if (can_execute)
        suggested = next_suggestion
        suggested.suggest_date!
        PresentationMailer.suggest_date_to(suggested).deliver if suggested
      end
    end
  end
end