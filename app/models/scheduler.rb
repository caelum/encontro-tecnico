class Scheduler

  def next_suggestion
    next_user = User.next_suggestion
    presentation = Presentation.where({scheduled_date: nil, suggested_date: nil, user_id: next_user.id}).order("created_at").first
    presentation.suggest_date!
  end

end