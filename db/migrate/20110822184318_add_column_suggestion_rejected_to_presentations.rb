class AddColumnSuggestionRejectedToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :suggestion_rejected, :boolean
  end
end
