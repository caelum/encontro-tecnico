Factory.sequence :email do |n|
  "user#{n}@caelum.com.br"
end

Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.name {email.split("@").first}
  u.password '123456'
end


Factory.define :presentation do |p|
  p.description "The most amazing presentation"
  p.name "How to be the best"
  p.association :user, :factory => :user
end

Factory.define :suggested_presentation, :parent => :presentation do |p|
  p.suggested_date Date.new!
end



Factory.define :scheduled_presentation, :parent => :suggested_presentation do |p|
  p.scheduled_date Date.new!
end
Factory.define :scheduled_and_rejected_presentation, :parent => :suggested_presentation do |p|
  p.suggestion_rejected true
end

