# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#2015
#感謝しましたか
Holiday.create(:holiday_name => '敬老の日', :holiday_date => '2015-09-21')
Holiday.create(:holiday_name => '父の日', :holiday_date => '2015-06-21')
Holiday.create(:holiday_name => '母の日', :holiday_date => '2015-05-10')
#帰省しましたか
Holiday.create(:holiday_name => '元日', :holiday_date => '2015-01-01')
Holiday.create(:holiday_name => '春分の日', :holiday_date => '2015-03-21')
Holiday.create(:holiday_name => '秋分の日', :holiday_date => '2015-09-23')

#2016
#感謝しましたか
Holiday.create(:holiday_name => '敬老の日', :holiday_date => '2016-09-19')
Holiday.create(:holiday_name => '父の日', :holiday_date => '2016-06-19')
Holiday.create(:holiday_name => '母の日', :holiday_date => '2016-05-08')
#帰省しましたか
Holiday.create(:holiday_name => '元日', :holiday_date => '2016-01-01')
Holiday.create(:holiday_name => '春分の日', :holiday_date => '2016-03-20')
Holiday.create(:holiday_name => '秋分の日', :holiday_date => '2016-09-22')


