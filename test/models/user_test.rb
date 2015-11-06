# -*- coding: utf-8 -*-
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should user name valid" do
    user = User.create(name: 'テスト太郎',email:'oyaco@oyaco.com',password:'testtest')
    assert user.valid?
  end

  test "should user name invalid" do
    invalid_name = 'テスト太郎テスト太郎テスト太郎テスト太郎テスト太郎テスト太郎テスト太郎テスト太郎テスト太郎テスト太郎テ'
    user = User.create(name: invalid_name ,email:'oyaco@oyaco.com',password:'testtest')
    assert user.invalid?
  end

end
