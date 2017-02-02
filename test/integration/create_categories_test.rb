require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
   
   test "get new category form and create category" do
       get new_category_path
       assert_template 'categories/new'
       assert_difference 'Category.count', 1 do # post to the new form
          post_via_redirect categories_path, category: {name: "sports"} # creating the category sports 
       end
       assert_template 'categories/index' # redirect after the creation
       assert_match "sports", response.body
   end 
   
   test "invalid category submission results in failure" do
       get new_category_path
       assert_template 'categories/new'
       assert_no_difference 'Category.count' do # post to the new form
          post categories_path, category: {name: ""} # different to the above as it is NOT redirecting
       end
       assert_template 'categories/new' # redirect after the creation
       assert_select 'h2.panel-title' # this can be found in the errors partial
       assert_select 'div.panel-body' # this can be found in the errors partial
   end
end