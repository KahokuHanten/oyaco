require "test_helper"

class RememberInputsTest < Capybara::Rails::TestCase
  test "remember inputs via cookie" do
    visit root_path
    within '#question-form' do
      fill_in 'dad', with: '1960-10-10'
      fill_in 'mom', with: '1960-10-10'
      select '東京都', from: 'pref_id'
      click_button 'recommend'
    end

    visit root_path

    assert page.has_button?('gototop')
  end

  test "forget cookie and set to default" do
    visit root_path
    within '#question-form' do
      fill_in 'dad', with: '1960-10-10'
      fill_in 'mom', with: '1960-10-10'
      select '東京都', from: 'pref_id'
      click_button 'recommend'
    end

    Capybara.current_session.reset!

    visit root_path

    within '#question-form' do
      assert_equal find_field('dad').value, '1950-10-31'
      assert_equal find_field('mom').value, '1950-12-31'
      assert_equal find_field('pref_id').value, PrefName.get_pref_id("北海道")
    end
  end
end
