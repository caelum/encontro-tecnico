Factory.sequence :email do |n|
  "user#{n}@caelum.com.br"
end

Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.password '123456'
end


Factory.define :presentation do |p|
  p.description "The most amazing presentation"
  p.name "How to be the best"
  p.association :user, :factory => :user
end

Factory.define :scheduled_presentation, :parent => :presentation do |p|
  date = Date.new!
  p.suggested_date date
  p.scheduled_date date
end

