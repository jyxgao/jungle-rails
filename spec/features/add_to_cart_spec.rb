require 'rails_helper'

RSpec.feature "AddProductToCarts", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Electronics'
    @category.products.create!(
      name: 'Toy Poodle',
      description: 'some maximum cute and furry dog toy.',
      image: '',
      quantity: 1,
      price: 5000
    )
  end

  scenario "a user who is not logged in adds a product to their cart" do
    visit '/'

    #find a product within and click on add
    first('article.product').find_button('Add').click
    
    #check if the nav UI
    find_link('My Cart (1)').click
    # puts page.html
    expect(page).to have_content "TOTAL"
    expect(page).to have_content "Toy Poodle"

    page.save_screenshot
  end
end
