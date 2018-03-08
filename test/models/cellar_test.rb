require 'test_helper'

class CellarTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @cellar = @user.cellars.build(name: "my cellar")
  end

  test "should be valid" do
    assert @cellar.valid?
  end

  test "user id should be present" do
    @cellar.user_id = nil
    assert_not @cellar.valid?
  end
  
  test "name should be present" do
    @cellar.name = "   "
    assert_not @cellar.valid?
  end

  test "name should be at most 140 characters" do
    @cellar.name = "a" * 21
    assert_not @cellar.valid?
  end
end
