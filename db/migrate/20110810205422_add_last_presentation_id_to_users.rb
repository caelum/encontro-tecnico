class AddLastPresentationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_presentation_id, :integer
  end
end
