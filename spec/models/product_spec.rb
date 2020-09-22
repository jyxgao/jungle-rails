require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should not exist for new records' do
      @category = Category.create(:name => 'Furniture')
      @category.save
      @product = Product.new

      expect(@product.id).to be_nil
    end

    it 'should have a name' do
      @category = Category.create(:name => 'Furniture')
      @category.save

      @product = @category.products.create(
        { name: nil,
        description: "This is a wooden antique chair that takes you back in time.", 
        quantity: 2,
        price: 987.65 }
      )
   
      expect(@product.name).to be_nil
    end

    it 'should have a description' do
      @category = Category.create(:name => 'Apparel')
      @category.save

      @product = @category.products.create(
        { name: "Lego",
        description: nil, 
        quantity: 30,
        price: 500.00 }
      )
      expect(@product.description).to be_nil
    end

    it 'should have a quantity' do
      @category = Category.create(:name => 'Electronics')
      @category.save

      @product = @category.products.create(
        { name: "Earpods",
        description: "These will make any sound come to life!", 
        quantity: nil,
        price: 90.00 }
      )
      expect(@product.quantity).to be_nil
    end

    it 'should belong to a category' do
      @category = Category.create(:name => 'Furniture')
      @category.save

      @product = @category.products.create(
        { name: "Dinner Table",
        description: "This huge table is enough to fit all your guests!", 
        quantity: 2,
        price: 500.00 }
      )
      expect(@product.category_id).to be_present
    end

  end
end
