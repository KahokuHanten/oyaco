# -*- coding: utf-8 -*-
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'should create person for user' do
    person = Person.new(relation: 0)
    user = User.find(1)
    person.user = user
    assert user.people.father.first, person
  end
end
