require 'test_helper'

class BobbReqControllerTest < ActionController::TestCase
  test "should get regist_user" do
    get :regist_user
    assert_response :success
  end

  test "should get access_log" do
    get :access_log
    assert_response :success
  end

  test "should get online_user_list" do
    get :online_user_list
    assert_response :success
  end

  test "should get request_battle" do
    get :request_battle
    assert_response :success
  end

  test "should get response_battlereq" do
    get :response_battlereq
    assert_response :success
  end

  test "should get battle_status" do
    get :battle_status
    assert_response :success
  end

  test "should get enemy_using_card" do
    get :enemy_using_card
    assert_response :success
  end

  test "should get regist_using_card" do
    get :regist_using_card
    assert_response :success
  end

  test "should get regist_selected_card" do
    get :regist_selected_card
    assert_response :success
  end

  test "should get enemy_selected_card" do
    get :enemy_selected_card
    assert_response :success
  end

  test "should get battle_stop" do
    get :battle_stop
    assert_response :success
  end

end
