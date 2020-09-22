require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should not exist for new records' do
      @user = User.new
      @user.save

      expect(@user.id).to be_nil
    end

    it 'should not save a new user if first name field is missing' do
      @user = User.create(
        :first_name => nil, 
        :last_name => 'Johnson', 
        :email => 'jjs@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc")
      @user.save
      
      expect(@user.save).to_not be true
    end

    it 'should not save a new user if last name field is missing' do
      @user = User.create(
        :first_name => 'Jones', 
        :last_name => nil, 
        :email => 'jjs@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc")
      @user.save
      
      expect(@user.save).to_not be true
    end

    it 'should not save a new user if email field is missing' do
      @user = User.create(
        :first_name => 'Jones', 
        :last_name => 'Smith', 
        :email => nil, 
        :password => "123abc", 
        :password_confirmation => "123abc")
      @user.save
      
      expect(@user.save).to_not be true
    end

    it 'should not save a new user if password is missing' do
      @user = User.create(
        :first_name => 'Jones', 
        :last_name => 'Smith', 
        :email => 'jjs@mail.com', 
        :password => nil,
        :password_confirmation => nil)
      @user.save
      
      expect(@user.save).to_not be true
    end

    it 'should not save a new user if confirmation password does not match' do
      @user = User.create(
        :first_name => 'Lucy', 
        :last_name => 'Johnson', 
        :email => 'jjs@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc3")
      @user.save
   
      expect(@user.save).to_not be true
    end    

    it 'should not accept password of less than 5 characters' do 
      @user = User.create(        
        :first_name => 'Mary', 
        :last_name => 'Johnson', 
        :email => 'jjss1@mail.com', 
        :password => "123a", 
        :password_confirmation => "123a")
      @user.save
 
    expect(@user.save).to_not be true
    end

    it 'should not save a user with an existing email' do
      @user1 = User.create(        
        :first_name => 'Bert', 
        :last_name => 'Johnson', 
        :email => 'jjss1@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc")

      @user2 = User.create(
        :first_name => 'Louis', 
        :last_name => 'Jeans', 
        :email => 'jjss1@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc"
      )
      expect(@user2.save).to_not be true
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        :first_name => 'Louis', 
        :last_name => 'Jeans', 
        :email => 'jeans1@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc"
      )
    end

    it 'should not log in user with invalid password' do
      @user = User.authenticate_with_credentials('jeans1@mail.com', '123abde')
      expect(@user).to be false
    end

    it 'should return user instance if logged in successfully' do
      @user = User.authenticate_with_credentials('jeans1@mail.com', '123abc')
      expect(@user.first_name).to match('Louis')
      expect(@user.last_name).to match('Jeans')
    end

    it 'should return a user using email with different case' do
      @user = User.authenticate_with_credentials('jeAnS1@mail.com', '123abc')
      expect(@user.first_name).to match('Louis')
      expect(@user.last_name).to match('Jeans') 
    end
  end
end
