require 'spec_helper'

RSpec.describe Nmax::NumberMax do
  let(:object) { described_class.new(limit) }
  let(:limit) { 7 }
  let(:sample) do
    '1478bbc38c96a683084a4b1e6333251d929b4cbc344972409d40c6da62a32a6e6f0'
  end

  describe 'CLI' do
    let(:nmax) { `echo #{sample} | nmax #{limit}` }
    context 'when one number argument' do
      it 'returns result array' do
        expect(nmax).to eq "[62, 96, 929, 1478, 683084, 6333251, 344972409]\n"
      end
    end

    context 'when not one' do
      let(:limit) { '23 fnord' }
      it 'return warning' do
        expect(nmax).to include 'Argument: must be one'
      end
    end

    context 'when not integer' do
      let(:limit) { 'fnord' }
      it 'return warning' do
        expect(nmax).to include 'Argument: must be integer'
      end
    end
  end

  describe '#find_nmax' do
    let(:subject) { object.send(:find_nmax) }
    before { object.input = StringIO.new(sample) }

    it 'should return array' do
      expect(subject).to be_a Array
    end
    it 'with size equals limit' do
      expect(subject.size).to eq limit
    end
  end

  describe '#process' do
    let(:subject) { object.send(:process, char) }

    context 'when char is number' do
      let(:char) { '3' }

      it 'should add char to digits_array' do
        expect(object.digits_array).to receive(:push).with(char.to_i)
        subject
      end
    end

    context 'when char is letter or smthing else' do
      let(:char) { 'b' }
      it 'should call try_add_result' do
        expect(object).to receive(:try_add_result)
        subject
      end
    end
  end

  describe '#try_add_result' do
    let(:subject) { object.send(:try_add_result) }

    context 'when digits_array is not empty' do
      before { object.digits_array = [3, 4] }
      it 'add number from digits_array to result' do
        expect(object).to receive(:add_result).with(34)
        subject
      end
      it 'clear digits_array' do
        expect(object.digits_array).to receive(:clear)
        subject
      end
    end
  end

  describe '#add_result(number)' do
    let(:subject) { object.send(:add_result, 420) }
    before { object.result_array = [128, 357, 666] }
    it 'should add number to result_array' do
      expect(object.result_array).to receive(:push).with(420)
      subject
    end

    context 'when array oversized' do
      before { object.limit = 3 }
      it 'should shift minimal value' do
        subject
        expect(object.result_array).to_not include(128)
      end
    end

    context 'when array under limit' do
      before { object.limit = 7 }
      it 'should not shift minimal value' do
        expect(object.result_array).to include(128)
      end
    end
  end
end
