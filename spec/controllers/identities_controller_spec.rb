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
        get :new
      end

      it { should redirect_to(sign_in_path) }
    end
  end
end
