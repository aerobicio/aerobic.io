require 'core_ext/string'

describe String do
  describe '#capitalize_first_letter' do
    subject { string.capitalize_first_letter }

    context 'when first letter is already capitalized' do
      let(:string) { 'Cleve DuBuque II' }

      it 'should not change the string' do
        subject.should == string
      end
    end

    context 'when the first letter is lower case' do
      let(:string) { 'going crazy yeah' }

      it 'should capitalize only the first letter of the string' do
        subject.should == 'Going crazy yeah'
      end
    end
  end
end
