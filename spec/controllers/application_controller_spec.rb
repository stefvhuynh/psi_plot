require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  context 'authentication' do
    let(:user) { double 'user' }
    let(:token) { '123abc' }

    before do
     allow(user).to receive(:reset_session_token!).and_return token
    end

    describe '#sign_in!' do
      before { subject.sign_in!(user) }

      it 'sets the @current_user instance variable' do
        expect(assigns(:current_user)).to eq user
      end

      it 'assigns the session token to a user session token' do
        expect(subject.session[:token]).to eq token
      end
    end

    describe '#sign_out!' do
      before do
        subject.sign_in!(user)
        allow(subject).to receive(:current_user).and_return user
        subject.sign_out!
      end

      it 'sets the session token to nil' do
        expect(subject.session[:token]).to be_nil
      end

      it 'sets @current_user to nil' do
        expect(assigns(:current_user)).to be_nil
      end
    end

    describe '#signed_in?' do
      it 'returns true if signed in' do
        subject.sign_in!(user)
        expect(subject.signed_in?).to be_truthy
      end

      it 'returns false if not signed in' do
        expect(subject.signed_in?).to be_falsey
      end
    end

    describe '#current_user' do
      it 'returns the cached @current_user' do
        subject.instance_variable_set(:@current_user, user)
        expect(subject.current_user).to eq user
      end

      it 'fetches the correct user' do
        user = FactoryGirl.create(:user)
        subject.sign_in!(user)
        subject.instance_variable_set(:@current_user, nil)
        expect(subject.current_user).to eq user
      end
    end
  end
end
