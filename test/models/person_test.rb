# -*- coding: utf-8 -*-
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'should create person for user' do
    person = Person.new(relation: 0)
    user = User.find(2)
    assert_equal 0, user.people.count

    person.user = user
    person.save

    assert_equal 1, user.people.count
    assert user.people.father.first
  end
end
