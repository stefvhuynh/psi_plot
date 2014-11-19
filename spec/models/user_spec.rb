require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { FactoryGirl.create(:user) }

  describe 'model validations' do
    describe 'first_name' do
      it 'requires a first_name' do
        expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
      end
    end
    
    describe 'last_name' do
      it 'requires a last_name' do
        expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
      end
    end
    
    describe 'email' do
      it 'requires an email' do
        expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
      end

      it 'requires a unique email' do
        FactoryGirl.create(:user, email: 'charliebrown@peanuts.com')
        expect(
          FactoryGirl.build(:user, username: 'charliebrown@peanuts.com')
        ).not_to be_valid
      end
      
      it 'requires a valid email' do
        expect(FactoryGirl.build(:user, email: 'invalid')).not_to be_valid
        expect(FactoryGirl.build(:user, email: 'inva@lid')).not_to be_valid
        expect(
          FactoryGirl.build(:user, email: 'i!n@v#a$.l%i^d')
        ).not_to be_valid
        expect(
          FactoryGirl.build(:user, email: 'charliebrown@peanuts.com')
        ).to be_valid
      end
    end

    describe 'session_token' do
      it 'requires a session_token' do
        user = FactoryGirl.build(:user)
        user.session_token = nil
        expect(user).not_to be_valid
      end

      it 'requires a unique session_token' do
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        user2.session_token = user1.session_token
        expect(user2).not_to be_valid
      end
    end

    describe 'password_digest' do
      it 'requires a password_digest' do
        user = FactoryGirl.create(:user)
        user.password_digest = nil
        expect(user).not_to be_valid
      end
    end

    describe 'password' do
      it 'requires the password to be at least six characters long' do
        expect(FactoryGirl.build(:user, password: '12345')).not_to be_valid
        expect(FactoryGirl.build(:user, password: '123456')).to be_valid
      end
    end
  end

  describe 'auto-generated attributes' do
    it 'creates a password_digest' do
      expect(user.password_digest).not_to be_nil
    end

    it 'creates a session_token' do
      expect(user.session_token).not_to be_nil
    end
  end

  describe '::find_by_credentials' do
    let!(:user) do
      FactoryGirl.create(
        :user,
        email: 'charliebrown@peanuts.com',
        password: '123abc'
      )
    end

    it 'returns the user based on their credentials' do
      expect(
        User.find_by_credentials('charliebrown@peanuts.com', '123abc')
      ).to eq user
    end

    it 'does not return the user if the password is wrong' do
      expect(
        User.find_by_credentials('charliebrown', 'abc123')
      ).to be_nil
    end

    it 'returns nil if the user does not exit' do
      expect(
        User.find_by_credentials('charlie', '123abc')
      ).to be_nil
    end
  end

  describe '#is_password?' do
    it 'checks if the password is correct' do
      user = FactoryGirl.build(:user, password: '123abc')
      expect(user.is_password?('123abc')).to be_truthy
      expect(user.is_password?('abc123')).to be_falsey
    end
  end

  describe '#reset_session_token!' do
    it 'generates a new session token' do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to be_nil
      expect(user.session_token).not_to eq old_token
    end
  end

end
