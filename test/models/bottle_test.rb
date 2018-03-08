require 'test_helper'

class BottleTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @bottle = @user.bottles.build(appellation: "Haut-Médoc")
  end

  test "should be valid" do
    assert @bottle.valid?
  end

  test "user id should be present" do
    @bottle.user_id = nil
    assert_not @bottle.valid?
  end
  
  test "appellation should be present" do
    @bottle.appellation = "   "
    assert_not @bottle.valid?
  end

  test "appellation should be at most 30 characters" do
    @bottle.appellation = "a" * 31
    assert_not @bottle.valid?
  end
  
end
