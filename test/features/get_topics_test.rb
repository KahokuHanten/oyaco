# -*- coding: utf-8 -*-
require "test_helper"

class GetTopicsTest < Capybara::Rails::TestCase
  test "user get topics after input form" do
    visit root_path
    click_on 'try'
    click_on 'next'
    click_on 'next'

    within '#question-form' do
      select '大阪府', from: 'questionnaire_pref_code'
    end
    click_on 'next'

    click_on 'next'
    click_on 'go-home'

    assert_content page, "大阪府"

    visit root_path
    visit home_path

    assert_content page, "大阪府"
  end

  test "user redirect to root before input form" do
    browser = Capybara.current_session.driver.browser
    browser.clear_cookies

    visit home_path

    assert_equal "/", page.current_path
  end

  test "user back word and next" do
    visit root_path
    click_on 'try'
    click_on 'next'
    page.assert_selector("#backword")
    click_on 'next'
    page.assert_selector("#backword")
    click_on 'next'
    page.assert_selector("#backword")
    click_on 'next'
    page.assert_selector("#backword")
  end

end
