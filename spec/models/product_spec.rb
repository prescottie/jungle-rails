require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save a valid record to the database' do
      category = Category.new(name: 'cool')
      product = Product.new(name: 'cool thing', price: 1, quantity: 1, category: category)
      product.save!
      expect(product).to be_persisted
    end

    it "should be invalid without a name" do
      category = Category.new(name: 'cool')
      product = Product.new(price: 1, quantity: 1, category: category)
      product.save
      expect(product).to_not be_valid
      expect(product.errors.full_messages[:name]).to include('can\'t be blank')
    end

    it "should be invalid without a price" do
      category = Category.new(name: 'cool')
      product = Product.new(name: 'cool thing', quantity: 1, category: category)
      product.save
      expect(product).to_not be_valid
      expect(product.errors.full_messages[:price]).to include('can\'t be blank')
    end

    it "should be invalid without a quantity" do
      category = Category.new(name: 'cool')
      product = Product.new(name: 'cool thing', price: 1, category: category)
      product = Product.new
      product.save
      expect(product).to_not be_valid
      expect(product.errors.full_messages[:quantity]).to include('can\'t be blank')
    end

    it "should be invalid without a category" do
      category = Category.new(name: 'cool')
      product = Product.new(name: 'cool thing', price: 1, quantity: 1)
      product = Product.new
      product.save
      expect(product).to_not be_valid
      expect(product.errors.full_messages[:category]).to include('can\'t be blank')
    end
  end
end
