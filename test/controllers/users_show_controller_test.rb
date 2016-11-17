require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "pinned card should always be six" do
		get user_path(1)
		assert_response :success

		assert_select ".sortable-card", 6
	end
end
