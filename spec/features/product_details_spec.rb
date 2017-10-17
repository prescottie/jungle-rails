require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario 'Able to get to a single product page from home page' do 
    visit root_path

    first('a.btn.btn-default').click

    
    expect(page).to have_content 'Apparel »'
    save_screenshot 'product_details.png'

  end
end
