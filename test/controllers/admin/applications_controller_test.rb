require 'test_helper'

class Admin::ApplicationsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:admin)

    sign_in_as(@user)
  end

  test "GET #index renders" do
    get :index

    assert_response :ok
  end

  test "DELETE #destroy destroys a given application and the associated sponsor group" do
    application = applications(:in_progress)

    assert_difference 'Application.count', -1 do
      assert_difference 'SponsorGroup.count', -1 do
        delete :destroy, id: application.id
      end
    end
  end
end
