require "test_helper"

class RememberInputsTest < Capybara::Rails::TestCase
  test "remember inputs via cookie" do
    visit root_path
    click_on '試してみる'

    within '#question-form' do
      select '1960', from: 'questionnaire[dad(1i)]'
      select '10', from: 'questionnaire[dad(2i)]'
      select '11', from: 'questionnaire[dad(3i)]'

      select '1960', from: 'questionnaire[mom(1i)]'
      select '10', from: 'questionnaire[mom(2i)]'
      select '11', from: 'questionnaire[mom(3i)]'

      select '東京都', from: 'pref_id'
      click_button 'recommend'
    end

    visit root_path
    click_on '試してみる'

    assert_equal find_field('questionnaire[dad(1i)]').value, '1960'
    assert_equal find_field('questionnaire[dad(2i)]').value, '10'
    assert_equal find_field('questionnaire[dad(3i)]').value, '11'

    assert_equal find_field('questionnaire[mom(1i)]').value, '1960'
    assert_equal find_field('questionnaire[mom(2i)]').value, '10'
    assert_equal find_field('questionnaire[mom(3i)]').value, '11'

    assert_equal find_field('pref_id').value, PrefName.get_pref_id("東京都")
  end

  test "remember inputs on welcom" do
    visit root_path
    click_on '試してみる'

    within '#question-form' do
      select '1960', from: 'questionnaire[dad(1i)]'
      select '2', from: 'questionnaire[dad(2i)]'
      select '1', from: 'questionnaire[dad(3i)]'

      select '1960', from: 'questionnaire[mom(1i)]'
      select '10', from: 'questionnaire[mom(2i)]'
      select '11', from: 'questionnaire[mom(3i)]'

      select '東京都', from: 'pref_id'
      click_button 'recommend'
    end

    visit root_path
    visit welcome_path

    assert_content page, "2月 1日"
    assert_content page, "東京都"
    refute_content page, "10月11日"
  end

  test "forget cookie and set to default" do
    visit root_path
    click_on '試してみる'

    within '#question-form' do
      select '1960', from: 'questionnaire[dad(1i)]'
      select '10', from: 'questionnaire[dad(2i)]'
      select '10', from: 'questionnaire[dad(3i)]'

      select '1960', from: 'questionnaire[mom(1i)]'
      select '10', from: 'questionnaire[mom(2i)]'
      select '10', from: 'questionnaire[mom(3i)]'

      select '東京都', from: 'pref_id'
      click_button 'recommend'
    end

    click_on '質問をやり直す'

    within '#question-form' do
      assert_equal find_field('questionnaire[dad(1i)]').value, '1960'
      assert_equal find_field('questionnaire[dad(2i)]').value, '10'
      assert_equal find_field('questionnaire[dad(3i)]').value, '10'

      assert_equal find_field('questionnaire[mom(1i)]').value, '1960'
      assert_equal find_field('questionnaire[mom(2i)]').value, '10'
      assert_equal find_field('questionnaire[mom(3i)]').value, '10'

      assert_equal find_field('pref_id').value, PrefName.get_pref_id("北海道")
    end
  end
end
