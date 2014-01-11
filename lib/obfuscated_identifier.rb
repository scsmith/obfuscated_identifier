require "active_support/concern"
require "obfuscated_identifier/version"

module ObfuscatedIdentifier
  extend ActiveSupport::Concern

  def to_param
    self.class.to_identifier(id)
  end

  module ClassMethods
    attr_reader :identifier_length

    def obfusicate_identifier(pattern, offset, length = 16)
      @identifier_pattern = pattern
      @identifier_offset = offset
      @identifier_length = 16
    end

    def generate_identifier_pattern
      %w{0 1 2 3 4 5 6 7 8 9 a b c d e}.shuffle
    end

    def from_param(value)
      id = from_identifier(value)
      find_by_id!(id)
    end

    def from_identifier(value)
      counts = value.each_char.map { |c| @identifier_pattern.index(c.to_s) }.reverse

      numbers = counts[0..-2].each_with_index.map do |count, index|
        ((count - counts[index + 1]) - @identifier_offset) % @identifier_pattern.length
      end + [(counts[-1] - @identifier_offset) % @identifier_pattern.length]

      numbers.join('').to_i
    end

    def to_identifier(value)
      padded_string = pad_number(value)

      count = 0
      counts = padded_string.reverse.each_char.map do |c|
        count += (c.to_i + @identifier_offset)
        count = count % @identifier_pattern.length
      end

      counts.map { |c| @identifier_pattern[c] }.join('')
    end

    protected

    def pad_number(value)
      sprintf("%0#{@identifier_length}d", value)
    end
  end
end
