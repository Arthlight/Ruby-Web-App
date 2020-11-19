require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    assert_no_difference 'User.count' do
      post users_path params: { user: { name:  "",
                                        email: "user@invalid",
                                        password:              "foo",
                                        password_confirmation: "bar" }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path params: { user: { name: "Arthur",
                                        email: "Arthur@test.com",
                                        password: "TestPw443",
                                        password_confirmation: "TestPw443",
                                        }
      }
      follow_redirect!
      assert_template "users/show"
      assert_not flash.empty?
      assert is_logged_in?
    end
  end

end