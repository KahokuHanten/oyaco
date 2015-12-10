require 'test_helper'

class QuestionControllerTest < ActionController::TestCase
  test 'get dad should render correct template' do
    get(:show, 'id' => 'dad')
    assert_response :success
    assert_template :dad
  end

  test 'get mom should render correct template' do
    get(:show, 'id' => 'mom')
    assert_response :success
    assert_template :mom
  end

#  test 'get tel should render correct template' do
#    get(:show, 'id' => 'tel')
#    assert_response :success
#    assert_template :tel
#  end

  test 'get pref should render correct template' do
    get(:show, 'id' => 'pref')
    assert_response :success
    assert_template :pref
  end

  test 'get hobby should render correct template' do
    get(:show, 'id' => 'hobby')
    assert_response :success
    assert_template :hobby
  end

  test 'put dad should render correct template' do
    put(:update, 'id' => 'dad', 'q' => { 'dad(1i)' => '1955', 'dad(2i)' => '10', 'dad(3i)' => '10' })
    assert_response :redirect
    assert_redirected_to question_path(:mom)
  end

  test 'put mom should render correct template' do
    put(:update, 'id' => 'mom', 'q' => { 'mom(1i)' => '1955', 'mom(2i)' => '10', 'mom(3i)' => '10' })
    assert_response :redirect
    assert_redirected_to question_path(:pref)
  end

  test 'put pref should render correct template' do
    put(:update, 'id' => 'pref', 'pref_code' => 3)
    assert_response :redirect
    assert_redirected_to question_path(:wedding)
  end

#  test 'put tel should render correct template' do
#    put(:update, 'id' => 'tel', 'tel' => '123-456-789')
#    assert_response :redirect
#    assert_redirected_to question_path(:hobby)
#  end
end
