class Scheduler

  class << self
    def next_suggestion
      next_user = User.next_suggestion
      return nil if next_user.nil?

      presentation = Presentation.where("user_id = ? AND scheduled_date is null AND (suggested_date is null OR suggestion_rejected = ?)", next_user.id, true).order("created_at").first
    end

    def can_execute?
      none_suggested = Presentation.where("scheduled_date is null AND suggested_date is not null AND (suggestion_rejected is null OR suggestion_rejected = ?)", false).count < 1
      last_before_a_month = (4.weeks.from_now <=> Presentation.last_scheduled_date) > 0
      none_suggested && last_before_a_month
    end

    def execute
      if (can_execute?)
        suggested = next_suggestion
        suggested.suggest_date!
        PresentationMailer.suggest_date_to(suggested).deliver if suggested
      end
    end

    def notify_users
      presentation = Presentation.next_scheduled

      users = User.where("receive_mail = ?", true)
      users = users - [presentation.user]
      users.each { |user|
        PresentationMailer.notify_user(user, presentation).deliver
      }

      PresentationMailer.notify_speaker(presentation).deliver
    end
  end
end
