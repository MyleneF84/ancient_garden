require "application_system_test_case"

class Admins::CategoriesTest < ApplicationSystemTestCase
  setup do
    @admins_category = admins_categories(:one)
  end

  test "visiting the index" do
    visit admins_categories_url
    assert_selector "h1", text: "Categories"
  end

  test "should create category" do
    visit admins_categories_url
    click_on "New category"

    fill_in "Description", with: @admins_category.description
    fill_in "Name", with: @admins_category.name
    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "should update Category" do
    visit admins_category_url(@admins_category)
    click_on "Edit this category", match: :first

    fill_in "Description", with: @admins_category.description
    fill_in "Name", with: @admins_category.name
    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "should destroy Category" do
    visit admins_category_url(@admins_category)
    click_on "Destroy this category", match: :first

    assert_text "Category was successfully destroyed"
  end
end
