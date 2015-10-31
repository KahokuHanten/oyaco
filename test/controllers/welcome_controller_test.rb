# -*- coding: utf-8 -*-
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "redirect without cookies" do
    get :show, :dad => nil
    assert_redirected_to root_path
  end
end
