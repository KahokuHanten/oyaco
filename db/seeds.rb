# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or find_or_create_byd alongside the db with db:setup).
#
# Examples:
#
#   cities = City.find_or_create_by([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.find_or_create_by(name: 'Emanuel', city: cities.first)

# 2015
# 感謝しましたか
Holiday.find_or_create_by(name: '敬老の日', date: '2015-09-21')
Holiday.find_or_create_by(name: '父の日', date: '2015-06-21')
Holiday.find_or_create_by(name: '母の日', date: '2015-05-10')
# 帰省しましたか
Holiday.find_or_create_by(name: '元日', date: '2015-01-01')
Holiday.find_or_create_by(name: '春分の日', date: '2015-03-21')
Holiday.find_or_create_by(name: '秋分の日', date: '2015-09-23')

# 2016
# 感謝しましたか
Holiday.find_or_create_by(name: '敬老の日', date: '2016-09-19')
Holiday.find_or_create_by(name: '父の日', date: '2016-06-19')
Holiday.find_or_create_by(name: '母の日', date: '2016-05-08')
# 帰省しましたか
Holiday.find_or_create_by(name: '元日', date: '2016-01-01')
Holiday.find_or_create_by(name: '春分の日', date: '2016-03-20')
Holiday.find_or_create_by(name: '秋分の日', date: '2016-09-22')

# AdminUser.find_or_create_by(email: 'admin@example.com') do |m|
#   m.password = 'password'
#   m.password_confirmation = 'password'
# end
