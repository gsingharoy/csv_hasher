require 'spec_helper'
describe CSVHasher do
  describe '::hashify' do 
    
  end

  describe '::col_keys' do 
    context 'when all keys are lower case' do 
      it 'returns the keys as it is' do 
        msg = ['foo', 'bar', 'lorem']
        expected_response = [:foo, :bar, :lorem]
        expect(CSVHasher.send(:col_keys, msg)).to eq expected_response
      end
    end
    context 'when keys are capitalized' do 
      it 'returns the keys in lower case' do 
        msg = ['Foo', 'Bar', 'LOrem']
        expected_response = [:foo, :bar, :lorem]
        expect(CSVHasher.send(:col_keys, msg)).to eq expected_response
      end
    end
    context 'when keys have spaces' do 
      it 'returns the keys in spider case' do 
        msg = ['Foo Bar', 'Lorem  IPsum']
        expected_response = [:foo_bar, :lorem_ipsum]
        expect(CSVHasher.send(:col_keys, msg)).to eq expected_response
      end
    end
    context 'when keys have numbers' do 
      it 'returns numbers in the keys' do 
        msg = ['Foo Bar1', 'Lorem  IPsum2 4']
        expected_response = [:foo_bar1, :lorem_ipsum2_4]
        expect(CSVHasher.send(:col_keys, msg)).to eq expected_response
      end
    end
  end
end