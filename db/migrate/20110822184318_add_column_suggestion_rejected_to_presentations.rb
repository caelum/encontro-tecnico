class AddColumnSuggestionRejectedToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :suggestion_rejected, :booleand
  end
end
