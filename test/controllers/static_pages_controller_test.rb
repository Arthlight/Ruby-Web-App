require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Sample App"
  end

  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", text: "#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", text: "Help | #{@base_title}"
    # assert_select "title", count: 1, text: "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", count: 1, text: "About | #{@base_title}"
  end

  test"should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", count: 1, text: "Contact | #{@base_title}"
  end

end
