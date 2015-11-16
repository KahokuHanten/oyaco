# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or find_or_create_byd alongside the db with db:setup).
#
# Examples:
#
#   cities = City.find_or_create_by([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.find_or_create_by(name: 'Emanuel', city: cities.first)

# Holiday
Holiday.delete_all

# 2015
Holiday.find_or_create_by(name: 'シルバーウィーク', start_date: '2015-09-19', end_date: '2015-09-23')
Holiday.find_or_create_by(name: '敬老の日', date: '2015-09-21')
Holiday.find_or_create_by(name: '秋分の日', date: '2015-09-23')
Holiday.find_or_create_by(name: '勤労感謝の日', date: '2015-11-23')
Holiday.find_or_create_by(name: '大晦日', date: '2015-12-31')

# 2016
Holiday.find_or_create_by(name: '元日', date: '2016-01-01')
Holiday.find_or_create_by(name: '春分の日', date: '2016-03-20')
Holiday.find_or_create_by(name: 'ゴールデンウィーク', start_date: '2016-04-29', end_date: '2016-05-05')
Holiday.find_or_create_by(name: '母の日', date: '2016-05-08')
Holiday.find_or_create_by(name: '父の日', date: '2016-06-19')
Holiday.find_or_create_by(name: 'お盆', start_date: '2016-08-13', end_date: '2016-08-16')
Holiday.find_or_create_by(name: '敬老の日', date: '2016-09-19')
Holiday.find_or_create_by(name: '秋分の日', date: '2016-09-22')
Holiday.find_or_create_by(name: '勤労感謝の日', date: '2016-11-23')
Holiday.find_or_create_by(name: '大晦日', date: '2016-12-31')

# 2017
Holiday.find_or_create_by(name: '元日', date: '2017-01-01')
Holiday.find_or_create_by(name: '春分の日', date: '2017-03-20')
Holiday.find_or_create_by(name: 'ゴールデンウィーク', start_date: '2017-04-29', end_date: '2017-05-07')
Holiday.find_or_create_by(name: '母の日', date: '2017-05-14')
Holiday.find_or_create_by(name: '父の日', date: '2017-06-18')
Holiday.find_or_create_by(name: 'お盆', start_date: '2017-08-13', end_date: '2017-08-16')
Holiday.find_or_create_by(name: '敬老の日', date: '2017-09-18')
Holiday.find_or_create_by(name: '秋分の日', date: '2017-09-23')
Holiday.find_or_create_by(name: '勤労感謝の日', date: '2017-11-23')
Holiday.find_or_create_by(name: '大晦日', date: '2017-12-31')

# AdminUser.find_or_create_by(email: 'admin@example.com') do |m|
#   m.password = 'password'
#   m.password_confirmation = 'password'
# end
