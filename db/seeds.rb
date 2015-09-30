# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Holiday.create(:holiday_name => '敬老の日', :holiday_date => '2016-09-19')
Holiday.create(:holiday_name => '父の日', :holiday_date => '2016-06-19')
Holiday.create(:holiday_name => '母の日', :holiday_date => '2016-05-19')
