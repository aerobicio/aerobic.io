require 'spec_helper'

describe IdentitiesController do

  describe '#new', flip: true, sign_up: true do
    context 'when sign up is active' do
      before do
        $switch_board.stub(:sign_up_active?) { true }
        get :new
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context 'when sign up is not active' do
      before do
        $switch_board.stub(:sign_up_active?) { false }
      end

      context 'and no token param is set' do
        before do
          get :new
        end

        it { should redirect_to(sign_in_path) }
      end

      context 'and ENV["BETA_TOKEN"] is not set' do
        before do
          ENV.stub('BETA_TOKEN') { nil }
          get :new
        end

        it { should redirect_to(sign_in_path) }
      end

      context 'and the token param is set to an unrecognised value' do
        before do
          get :new, token: ENV['BETA_TOKEN'].dup.reverse!
        end

        it { should redirect_to(sign_in_path) }
      end

      context 'and the token param is set to ENV["BETA_TOKEN"]' do
        before do
          get :new, token: ENV['BETA_TOKEN']
        end

        it { should respond_with(:success) }
        it { should render_template(:new) }
      end
    end
  end
end
