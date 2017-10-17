require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should be invalid without a password' do
      user = User.new(first_name: 'a', last_name: 'd', email:'p@p.p', password_confirmation: 'qqqq')
      user.save
      expect(user).to_not be_valid
      expect(user.errors.messages[:password]).to include('can\'t be blank')
    end

    it 'should be invalid without a password confirmation' do 
      user = User.new(first_name: 'a', last_name: 'd', email:'p@p.p', password: 'qqqq')
      user.save
      expect(user).to_not be_valid
      expect(user.errors.messages[:password_confirmation]).to include('can\'t be blank')
    end

    it 'should have matching password and password confirmation fields' do 
      user = User.new(first_name: 'a', last_name: 'd', email:'p@p.p', password: 'qqqq1111', password_confirmation: 'qqqqqq111q')
      user.save
      expect(user.password).to_not eq(user.password_confirmation)
    end

    it 'should save user with valid fields and matching password and confirmation fields' do 
      user = User.new(first_name: 'a', last_name: 'd', email:'p@p.p', password: 'qqqqqq', password_confirmation: 'qqqqqq')
      user.save
      expect(user.password).to eq(user.password_confirmation)
      expect(user).to be_persisted
    end

    it 'should be invalid if email is not unique' do 
      user = User.new(first_name: 'a', last_name: 'd', email:'l@l.L', password: 'qqqqqq', password_confirmation: 'qqqqqq')
      user.save
      user2 = User.new(first_name: 'a', last_name: 'd', email:'L@l.L', password: 'qqqqqq', password_confirmation: 'qqqqqq')
      user2.save
      expect(user).to be_valid
      expect(user2).to_not be_valid
      expect(user2.errors.messages[:email]).to include('has already been taken')
    end

    it "should be invalid without an email" do
      user = User.new(first_name: '1', last_name: 'd', password: 'qqqqqq', password_confirmation: 'qqqqqq')
      user.save
      expect(user).to_not be_valid
      expect(user.errors.messages[:email]).to include('can\'t be blank')
    end    

    it "should be invalid without a first name" do
      user = User.new(last_name: 'd', email:'test@test.test', password: 'qqqqqq', password_confirmation: 'qqqqqq')
      user.save
      expect(user).to_not be_valid
      expect(user.errors.messages[:first_name]).to include('can\'t be blank')
    end

    it "should be invalid without a last name" do
      user = User.new(first_name: '1', email:'test@test.test', password: 'qqqqqq', password_confirmation: 'qqqqqq')
      user.save
      expect(user).to_not be_valid
      expect(user.errors.messages[:last_name]).to include('can\'t be blank')
    end

    it 'should be invalid if the password is less than 6 characters' do
      user = User.new(first_name: '1', last_name: 'f', email:'test@test.test', password: 'qqq', password_confirmation: 'qqq')
      user2 = User.new(first_name: '1', last_name: 'f', email:'tet@test.test', password: 'qqq222', password_confirmation: 'qqq222')
      user.save
      user2.save
      expect(user).to_not be_valid
      expect(user2).to be_valid
      expect(user.errors.messages[:password]).to include("is too short (minimum is 6 characters)")
      expect(user.errors.messages[:password_confirmation]).to include("is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do 
    it 'should return user if user is authenticated' do
      user = User.new(first_name: '1', last_name: 'f', email:'test@test.test', password: 'qqq222', password_confirmation: 'qqq222')
      user.save!
      user_auth = User.authenticate_with_credentials('test@test.test', 'qqq222')
      expect(user_auth).to eq(user)
    end

    it 'should return nil if credentials dont match' do
      user = User.new(first_name: '1', last_name: 'f', email:'test@test.test', password: 'qqq222', password_confirmation: 'qqq222')
      user.save!
      user_auth = User.authenticate_with_credentials('test@test.test', 'qqq333')
      expect(user_auth).to eq(nil)
    end

    it 'should return user if email input is wrong case' do
      user = User.new(first_name: '1', last_name: 'f', email:'test@test.test', password: 'qqq222', password_confirmation: 'qqq222')
      user.save!
      user_auth = User.authenticate_with_credentials('tESt@tEst.tesT', 'qqq222')
      expect(user_auth).to eq(user)
    end

    it 'should return user if email input is has spaces' do
      user = User.new(first_name: '1', last_name: 'f', email:'test@test.test', password: 'qqq222', password_confirmation: 'qqq222')
      user.save!
      user_auth = User.authenticate_with_credentials('  tESt@tEst.tesT   ', 'qqq222')
      expect(user_auth).to eq(user)
    end
  end
end
