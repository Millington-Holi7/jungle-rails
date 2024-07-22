require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with a first name, last name, email, password, and password confirmation' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'is invalid without a password' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid when password and password confirmation do not match' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'different')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid without an email' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: nil, password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is invalid without a first name' do
      user = User.new(first_name: nil, last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is invalid without a last name' do
      user = User.new(first_name: 'John', last_name: nil, email: 'john@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid with a duplicate email (case insensitive)' do
      User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'TEST@TEST.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is invalid with a password less than 6 characters' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'is invalid with an improperly formatted email' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'invalidemail', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    describe '.authenticate_with_credentials' do
      before(:each) do
        @user = User.create(
          first_name: 'Test',
          last_name: 'User',
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
      end
  
      it 'authenticates with correct credentials' do
        user = User.authenticate_with_credentials('test@example.com', 'password')
        expect(user).to eq(@user)
      end
  
      it 'returns nil with incorrect email' do
        user = User.authenticate_with_credentials('wrong@example.com', 'password')
        expect(user).to be_nil
      end
  
      it 'returns nil with incorrect password' do
        user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
        expect(user).to be_nil
      end
  
      it 'authenticates with email having leading/trailing spaces' do
        user = User.authenticate_with_credentials('  test@example.com  ', 'password')
        expect(user).to eq(@user)
      end
  
      it 'authenticates with email in different case' do
        user = User.authenticate_with_credentials('TEST@example.com', 'password')
        expect(user).to eq(@user)
    end
  end
end
end