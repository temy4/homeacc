require 'test_helper'

class DataImportControllerTest < ActionController::TestCase
  test "should get import_csv" do
    get :import_csv
    assert_response :success
  end

end
