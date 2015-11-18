# -*- coding: utf-8 -*-
require "test_helper"

class CanRecommendTopicsTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert_content page, "OYACO"
  end

  test "user enters valid input" do
    visit root_path
    click_on '試してみる'

    within '#question-form' do
      select '1960', from: 'questionnaire[dad(1i)]'
      select '9', from: 'questionnaire[dad(2i)]'
      select '10', from: 'questionnaire[dad(3i)]'
    end
    click_on 'next'

    within '#question-form' do
      select '1960', from: 'questionnaire[mom(1i)]'
      select '2', from: 'questionnaire[mom(2i)]'
      select '1', from: 'questionnaire[mom(3i)]'
    end
    click_on 'next'

    within '#question-form' do
      select '東京都', from: 'questionnaire_pref_id'
    end
    click_on 'next'
    click_on 'next'
    click_on 'go-home'
    assert_content page, "2月 1日"
    refute_content page, "9月10日"
    assert_content page, "東京都"
  end
end
