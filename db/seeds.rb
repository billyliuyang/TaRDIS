# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Fte.delete_all
# LineStaff.delete_all
# Staff.delete_all
# Task.delete_all
# Study.delete_all
# TimeManagement.delete_all

%w(act16yl acs16qd acr16cis aca03cem cm1srw cm1kjp ac4hh ac6gene).each do |username|
  account = User.where(username: username).first_or_initialize
  account.get_info_from_ldap
  account.role = :admin
  account.save
end

%w(acp15as).each do |username|
  account = User.where(username: username).first_or_initialize
  account.get_info_from_ldap
  account.role = :manager
  account.save
end