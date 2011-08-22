class Scheduler

  def next_suggestion
    next_user = User.next_suggestion
    presentation = Presentation.where("user_id = ? AND scheduled_date is null AND (suggested_date is null OR suggestion_rejected = ?)", next_user.id, true).order("created_at").first
    presentation.suggest_date!
  end

end