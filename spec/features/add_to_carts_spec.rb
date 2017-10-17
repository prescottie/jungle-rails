require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    5.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Able to add a single product to their cart from home page' do 
    visit root_path

    first('a.btn.btn-primary').click

    expect(page).to have_content 'My Cart (1)'
    save_screenshot 'add_to_cart.png'

  end
end
