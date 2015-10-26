require "test_helper"

class GetTopicsTest < Capybara::Rails::TestCase
  test "user get topics after input form" do
    visit root_path
    within '#question-form' do
      select '大阪府', from: 'pref_id'
      click_button 'recommend'
    end
    visit root_path
    visit welcome_path

    assert_content page, "大阪府"
  end
end
