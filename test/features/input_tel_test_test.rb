require "test_helper"

class InputTelTestTest < Capybara::Rails::TestCase
  test "user inputs valid number" do
    visit root_path
    within '#question-form' do
      fill_in 'tel', with: '00-0000-0000'
      click_button 'recommend'
    end

    refute page.find('#tel')[:class].include?("disabled")
  end

  test "user don't input number" do
    visit root_path
    within '#question-form' do
      fill_in 'tel', with: ''
      click_button 'recommend'
    end

    assert page.find('#tel')[:class].include?("disabled")
  end
end
