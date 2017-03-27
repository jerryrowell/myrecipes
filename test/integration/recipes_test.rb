require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "jerry", email: "jerry@example.com")
    @recipe = Recipe.create(name: "vegatble saute", description: "greate vagatble sautee, add vegatble and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken saute", description: "greate chicken dish")
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name

  end
  
  test "create new valid recipe" do 
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe="chicken saute"
    description_of_recipe= "Add chicken, add vegetables, cook for 20 minutes, serve delicious meal"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params:{recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params:{recipe: {name: " ", description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
