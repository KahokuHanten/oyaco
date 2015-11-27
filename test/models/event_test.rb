require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'should create event for user' do
    user = User.find(1)
    user.events.create(name: "テストの日", date: "2016-01-01")
    assert_equal "テストの日", user.events.first.name
  end

  test 'should delete event for user' do
    user = User.find(2)
    assert_equal 2, user.events.count

    event = user.events.first
    event.destroy
    assert_equal 1, user.events.count
  end
end
