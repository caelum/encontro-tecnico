class Scheduler

  def next_suggestion
    next_user = User.next_suggestion
    presentation = Presentation.where("user_id = ? AND scheduled_date is null AND (suggested_date is null OR suggestion_rejected = ?)", next_user.id, true).order("created_at").first
    presentation.suggest_date!
  end


  def can_execute
    Presentation.where("scheduled_date is null AND suggested_date is not null AND suggestion_rejected is null").count < 1
  end
end