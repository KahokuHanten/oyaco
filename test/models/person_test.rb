# -*- coding: utf-8 -*-
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth"
  #   assert true
  # end

  test "should create user" do
    assert !Person.exists?(user_id:2,relation:0)
    assert !Person.exists?(user_id:2,relation:1)
    Person.new.save_current_user_birthday(2,"2015-10-10","2015-11-11")
    assert_not_nil Person.where(user_id:2,relation:0)
    assert_not_nil Person.where(user_id:2,relation:1)
  end

  test "should update birthdaty" do
    Person.new.save_current_user_birthday(1,"2015-10-10","2015-11-11")
    assert_equal people(:one).birthday.strftime("%Y-%m-%d"),"2015-10-10"
    assert_equal people(:three).birthday.strftime("%Y-%m-%d"),"2015-11-11"
  end
end
