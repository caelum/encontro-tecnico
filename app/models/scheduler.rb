class Scheduler

  def next_suggestion
    next_user = User.next_suggestion
    Presentation.where({scheduled_date: nil, suggested_date: nil, user_id: next_user.id}).order("created_at").first
  end

end