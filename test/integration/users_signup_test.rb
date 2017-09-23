require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                 email: "use@noright",
                                 password: "123",
                                 password_confirmation: "1234"
                                }      }
    end
    assert_template 'users/new'
    #assert_select 'div#<CSS id for error explanation>'
    #assert_select 'div.<CSS class for field with error>'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "test",
                                 email: "test@example.com",
                                 password: "testtest",
                                 password_confirmation: "testtest"
                                }      }
    end
    follow_redirect!
    assert_template 'users/show'
    #assert_not flash.FILL_IN
  end
end
