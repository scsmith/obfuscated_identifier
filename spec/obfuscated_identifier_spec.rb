require 'spec_helper'
require 'obfuscated_identifier'

class ObfuscatedIdentifierClass
  include ObfuscatedIdentifier

  obfusicate_identifier(
    %w{2 7 3 e 6 9 1 8 b c 5 a 4 d 0},
    7,
    16
  )
end

describe ObfuscatedIdentifier do
  let(:klass) { ObfuscatedIdentifierClass }
  let(:postgres_max_identifier) { (2**(4 * 8 - 1) - 1) }
  let(:example_identifier) { 'b2801d946ae53c7b' }
  let(:example_number) { 1 }

  describe '#pad_number' do
    it 'returns a string' do
      expect(klass.send(:pad_number, 1)).to be_instance_of(String)
    end

    context 'when number is 1' do
      it 'returns the number padded with 0s' do
        expect(klass.send(:pad_number, 1)).to eq('0000000000000001')
      end
    end

    context 'when number is greater than the padding' do
      it 'returns the number as a string' do
        expect(klass.send(:pad_number, 999_999_999_999_999_999)).to eq('999999999999999999')
      end
    end

    context 'when number is the max identifier postgres int type allows' do
      it 'returns the number as a string' do
        expect(klass.send(:pad_number, postgres_max_identifier)).to eq('0000002147483647')
      end
    end
  end

  describe '#to_identifier' do
    it 'returns a string' do
      expect(klass.to_identifier(1)).to be_instance_of(String)
    end

    it 'returns a value with length LENGTH' do
      expect(klass.to_identifier(1).length).to eq(klass.identifier_length)
    end

    it 'returns the expect identifier' do
      expect(klass.to_identifier(1)).to eq(example_identifier)
    end

    it 'creates a reversable identifier' do
      100.times do
        number = rand(0..postgres_max_identifier)
        identifier = klass.to_identifier(number)
        expect(klass.from_identifier(identifier)).to eq(number)
      end
    end
  end

  describe '#from_identifier' do
    it 'returns a number' do
      expect(klass.from_identifier(example_identifier)).to be_instance_of(Fixnum)
    end

    it 'returns the expected integer' do
      expect(klass.from_identifier(example_identifier)).to eq(example_number)
    end
  end

  describe 'generate_identifier_pattern' do
    it 'returns 0-9a-f' do
      klass.generate_identifier_pattern.each do |item|
        expect(item).to match(/[a-f 0-9]/)
      end
    end

    it 'returns each item only once' do
      output = klass.generate_identifier_pattern
      expect(output.uniq).to eq(output)
    end

    it 'generates a different pattern each time' do
      output = klass.generate_identifier_pattern
      expect(klass.generate_identifier_pattern).not_to eq(output)
    end
  end
end
