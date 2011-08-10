class Scheduler

  def next_suggestion
    Presentation.last
  end

end