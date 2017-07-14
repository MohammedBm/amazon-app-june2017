require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'title' do

    it "must be present" do
      p = Product.new(title: nil, description: "Has already been created or use ", price: 900)
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "must be unique" do
      title1 = Product.create(title: 'Banana', description: "Has already been created or used ", price: 900)
      title2 = Product.new(title: 'Banana', description: "Has already been created or used ", price: 900)
      title2.valid?
      expect(title2.errors.messages).to have_key(:title)
    end

    it "must be captlized" do
      p = Product.create(title: 'banana', description: "Has already been created or used ", price: 900)
      p.valid?
      expect(p.title).to eq("Banana")
    end

  end

  describe 'description' do

    it "must be present" do
      p = Product.new(title:'Product from space', description:nil, price: 900)
      p.valid?
      expect(p.errors).to have_key(:description)
    end

  end

  describe 'Price' do

    it 'defaults the price to 1 if not present' do
      # p = Product.new(title:'Product from space', description:'An item from the outer space created by aliens', price: nil)
      # # p.valid?
      # # byebug
      # p.save
      # expect(p.reload.price).to eq(1)
      p = Product.new(title:'Product from space', description:nil, price: 9900)
      p.price = nil
      p.valid?
      expect(p.errors).to have_key(:price)
    end

    it "must be more than 0" do
      # p = Product.new(title:'Product from space', description:'An item from the outer space created by aliens', price: 0)
      # p.valid?
      # expect(p.errors).to have_key(:price)

      p = Product.new(title:'Product from space', description:'An item from the outer space created by aliens', price: 300)
      p.valid?
      expect(p.price).to be > 0



    end

  end






end
