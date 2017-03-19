require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create(chefname: "jerry", email: "jerry@example.com")
    @recipe = Recipe.create(name: "vegatble saute", description: "greate vagatble sautee, add vegatble and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken saute", description: "greate chicken dish")
    @recipe2.save
  end
  
  test "should get recipes indes" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end
