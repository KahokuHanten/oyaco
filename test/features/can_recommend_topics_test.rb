# -*- coding: utf-8 -*-
require "test_helper"

class CanRecommendTopicsTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert_content page, "OYACO"
  end

  test "user enters valid input" do
    visit root_path
    click_on 'try'

    father_birthday = Date.current.next_month(1)

    within '#question-form' do
      select '1960', from: 'questionnaire[dad(1i)]'
      select father_birthday.month, from: 'questionnaire[dad(2i)]'
      select father_birthday.day, from: 'questionnaire[dad(3i)]'
    end
    click_on 'next'

    mother_birthday = Date.current.next_month(2)
    within '#question-form' do
      select '1960', from: 'questionnaire[mom(1i)]'
      select mother_birthday.month, from: 'questionnaire[mom(2i)]'
      select mother_birthday.day, from: 'questionnaire[mom(3i)]'
    end
    click_on 'next'

    within '#question-form' do
      select '東京都', from: 'questionnaire_pref_code'
    end

    click_on 'next'
    click_on 'next'
    click_on 'go-home'
    assert_content page, father_birthday.month.to_s+"月"+father_birthday.day.to_s.rjust(2, ' ')+"日"
    assert_content page, mother_birthday.month.to_s+"月"+mother_birthday.day.to_s.rjust(2, ' ')+"日"
    assert_content page, "東京都"
  end
end
