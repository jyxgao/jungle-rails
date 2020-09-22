require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should not exist for new records' do
      @user = User.new
      @user.save

      expect(@user.id).to be_nil
    end

    it 'should not save a new user if confirmation password does not match' do
      @user = User.create(
        :first_name => 'Jenny', 
        :last_name => 'Johnson', 
        :email => 'jjs@mail.com', 
        :password => "123abc", 
        :password_confirmation => "123abc3")
      @user.save
   
      expect(@user.save).to_not be true
    end    

    it 'should not accept password of less than 5 characters' do 
      @user = User.create(        
        :first_name => 'Jennifer', 
        :last_name => 'Johnson', 
        :email => 'jjss1@mail.com', 
        :password => "123a", 
        :password_confirmation => "123a")
      @user.save
 
    expect(@user.save).to_not be true
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should log in a valid user' do
      
    end
  end
end
