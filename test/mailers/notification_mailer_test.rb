require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "send email" do
    # メールを送信後キューに追加されるかどうかをテスト
    user = User.find(3)
    holidays = Holiday.all
    events = [Event.find(3)]
    email = NotificationMailer.mail_notice(user, events, holidays).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # 送信されたメールの本文が期待どおりの内容であるかどうかをテスト
    assert_equal ['no-reply@herokuapp.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'OYACOからのお知らせ', email.subject
    # assert_equal read_fixture('mail_notice.html').join, email.body.to_s
  end
end
