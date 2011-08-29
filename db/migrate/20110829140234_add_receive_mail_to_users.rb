class AddReceiveMailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_mail, :boolean
    User.all.each {|u| u.update_attribute :receive_mail, true}
  end
end
