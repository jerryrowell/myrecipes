require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    
    @chef = Chef.create(chefname: "jerry", email: "jerry@example.com",
              password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "chicken parm", description: "heat oil, add onions, add tomato sauce, add chicken, cook for 20 minutes")
  end
  
   test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "name length should't be more than 500 characters" do
    @recipe.description= "a" * 501
    assert_not @recipe.valid?
  end
  
  test "name length should't be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
end