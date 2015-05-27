require 'spec_helper'
describe CSVHasher do
  describe '::hashify' do
    context 'when no file exists' do
      it 'raises error Errno::ENOENT' do
        expect{
          CSVHasher.hashify('/incorrect/path/to/csv')
        }.to raise_error Errno::ENOENT
      end
    end
    context 'when file exists' do
      let(:sample1_path) { File.join(
                              File.expand_path(File.dirname(__FILE__)),
                              '..',
                              'fixtures',
                              'sample1.csv') }
      context 'sample1.csv file' do
        before do
          @header_keys = [:col_1, :col_2, :col_3]
          @total_rows = 3
        end
        it 'does not raise any error' do
          expect{
            CSVHasher.hashify(sample1_path)
          }.to_not raise_error
        end
        it 'returns the headers as keys' do
          returned_arrs = CSVHasher.hashify(sample1_path)
          returned_arrs.each do |ra|
            expect(ra.keys).to eq @header_keys
          end
        end
        it "returns #{@total_rows} hashes" do
          expect(CSVHasher.hashify(sample1_path).count).to eq @total_rows
        end
        [1, 2, 3].each do |col_no|
          it "returns correct values for the column :col_#{col_no}" do
            returned_arrs = CSVHasher.hashify(sample1_path)
            offset_val = ""
            returned_arrs.each do |ra|
              ra["col_#{col_no}".to_sym] = offset_val + col_no.to_s
              offset_val += col_no.to_s
            end
          end
        end
        context 'when keys are passed in options parameter' do
          it 'returns arrays of hashes with the keys passed' do
            msg_keys = ['col 1', 'col 2', 'col 3']
            returned_arrs = CSVHasher.hashify(sample1_path, { keys: msg_keys })
              returned_arrs.each do |ra|
              expect(ra.keys).to eq msg_keys
            end
          end
        end
        context 'when original_col_as_keys is true' do
          it 'returns arrays of hashes with original headers as keys' do
            col_arr = ['col 1', 'col 2', 'col 3']
            returned_arrs = CSVHasher.hashify(sample1_path, { original_col_as_keys: true })
            returned_arrs.each do |ra|
              expect(ra.keys).to eq col_arr
            end
          end
        end
      end
    end
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