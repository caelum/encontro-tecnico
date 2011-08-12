# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

User.create!(name: "Guilherme Silveira", email: "guilherme.silveira@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Adriano Almeida", email: "adriano.almeida@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Caires", email: "caires.santos@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Gabriel", email: "gabriel.oliveira@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Lucas Cavalcanti", email: "lucas.cavalcanti@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Mauricio Aniche", email: "mauricio.aniche@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Luiz (Sr. Saúde)", email: "luiz.real@caelum.com.br", password: "123456", password_confirmation: "123456")
User.create!(name: "Atoji", email: "alexandre.atoji@caelum.com.br", password: "123456", password_confirmation: "123456")