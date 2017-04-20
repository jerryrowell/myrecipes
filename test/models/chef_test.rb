require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "jerry", email: "jerry@example.com",
              password: "password", password_confirmation: "password")
  end
  
  test "should be valid" do
    assert @chef.valid?
  end
  
  test "name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "name length should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email should not be to long" do
    @chef.email = "a" * 245 + "example.com"
    assert_not @chef.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |valids|
      @chef.email = valids
      assert @chef.valid?, '#{valids.inspect} should be valid'
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, '#{invalids.inspect} should be invalid'
    end
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "John@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
  
  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end
  
  test "password should be at lest 5 characters" do
     @chef.password = @chef.password_confirmation = "x" * 4
     assert_not @chef.valid?
  end
  
  test "associated recipes should be destroy" do
    @chef.save
    @chef.recipes.create!(name: "testing destroy", description: "testing destroy fuction")
    assert_difference 'Recipe.count', -1 do
      @chef.destroy
    end
  end
  
end