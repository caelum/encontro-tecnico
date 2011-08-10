class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.date :suggested_date
      t.date :scheduled_date
      t.string :name
      t.string :description
      t.integer :speaker_id

      t.timestamps
    end
  end
end
