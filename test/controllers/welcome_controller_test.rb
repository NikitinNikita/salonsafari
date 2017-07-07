require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get affro" do
    get :affro
    assert_response :success
  end

  test "should get chemicalperm" do
    get :chemicalperm
    assert_response :success
  end

  test "should get contacts" do
    get :contacts
    assert_response :success
  end

  test "should get gallery" do
    get :gallery
    assert_response :success
  end

  test "should get haircare" do
    get :haircare
    assert_response :success
  end

  test "should get haircoloring" do
    get :haircoloring
    assert_response :success
  end

  test "should get haircut" do
    get :haircut
    assert_response :success
  end

  test "should get hairextension" do
    get :hairextension
    assert_response :success
  end

  test "should get hairstyling" do
    get :hairstyling
    assert_response :success
  end

  test "should get makeup" do
    get :makeup
    assert_response :success
  end

  test "should get manicure" do
    get :manicure
    assert_response :success
  end

  test "should get service" do
    get :service
    assert_response :success
  end

end
