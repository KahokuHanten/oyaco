require "test_helper"

class AgeCommentTestTest < Capybara::Rails::TestCase
  test "age comment" do
    test_datas = {"還暦" => 61, "喜寿" => 77}
    test_datas.keys.each do |test_comment|
      visit root_path
      click_on 'try'

      test_date = Date.current.years_ago(test_datas[test_comment] - 1)
      within '#question-form' do
        select test_date.year, from: 'questionnaire[dad(1i)]'
        select test_date.month, from: 'questionnaire[dad(2i)]'
        select test_date.day, from: 'questionnaire[dad(3i)]'
      end
      click_on 'next'

      within '#question-form' do
        select test_date.year, from: 'questionnaire[mom(1i)]'
        select test_date.month, from: 'questionnaire[mom(2i)]'
        select test_date.day, from: 'questionnaire[mom(3i)]'
      end
      click_on 'next'

      within '#question-form' do
        select '東京都', from: 'questionnaire_pref_id'
      end
      click_on 'next'
      click_on 'next'
      click_on 'go-home'
      assert_content page, test_comment
    assert_content page, "平均寿命"
    end
  end
end
