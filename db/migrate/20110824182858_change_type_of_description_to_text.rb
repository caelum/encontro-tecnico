class ChangeTypeOfDescriptionToText < ActiveRecord::Migration
  def up
    change_table :presentations do |t|
      t.change :description, :text
    end
  end

  def down
    change_table :presentations do |t|
      t.change :description, :string
    end
  end
end
