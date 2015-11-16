require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "event_email" do
    # メールを送信後キューに追加されるかどうかをテスト
    user = User.first
    events = [Holiday.second, Holiday.first, ]
    email = NotificationMailer.event_mail(user, events).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # 送信されたメールの本文が期待どおりの内容であるかどうかをテスト
    assert_equal ['no-reply@herokuapp.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'OYACOからのお知らせ', email.subject
    assert_equal read_fixture('event_mail.html').join, email.body.to_s
  end
end
