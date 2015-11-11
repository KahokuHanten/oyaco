# -*- coding: utf-8 -*-
require "test_helper"

class GetTopicsTest < Capybara::Rails::TestCase
  test "user get topics after input form" do
=begin ishikawa comment out
    visit root_path
    click_on '試してみる'

    within '#question-form' do
      select '大阪府', from: 'pref_id'
      click_button 'recommend'
    end

    visit root_path

    visit welcome_path

    assert_content page, "大阪府"
=end
  end

=begin
  test "user redirect to root before input form" do
    browser = Capybara.current_session.driver.browser
    browser.clear_cookies

    visit welcome_path

    assert_equal page.current_path, "/"
  end
=end
end
