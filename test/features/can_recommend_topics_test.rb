# -*- coding: utf-8 -*-
require "test_helper"

class CanRecommendTopicsTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert_content page, "OYACO"
  end

  test "user enters valid input" do
=begin ishikawa comment out
    visit root_path
    click_on '試してみる'
    within '#question-form' do
      select '1960', from: 'questionnaire[dad(1i)]'
      select '10', from: 'questionnaire[dad(2i)]'
      select '10', from: 'questionnaire[dad(3i)]'

      select '1960', from: 'questionnaire[mom(1i)]'
      select '10', from: 'questionnaire[mom(2i)]'
      select '10', from: 'questionnaire[mom(3i)]'

      select '北海道', from: 'pref_id'

      click_button 'recommend'
    end

    # TODO: check birthday
    assert_content page, "北海道"
=end
  end
end
