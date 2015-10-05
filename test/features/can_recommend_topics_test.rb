require "test_helper"

class CanRecommendTopicsTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert_content page, "OYAKO"
  end

  test "user enters valid input" do
    visit root_path
    within '#question-form' do
      fill_in 'dad', with: '1960-10-10'
      fill_in 'man', with: '1960-10-10'
      select '北海道', from: 'pref_id'
      click_button 'recommend'
    end

    # TODO: check birthday
    assert_content page, "北海道"
  end
end
