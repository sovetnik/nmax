module Nmax
  class NumberMax
    def self.parse
      return puts 'Argument: must be one' unless ARGV.size == 1
      return puts 'Argument: must be integer' if ARGV.first =~ /\D+/
      p new(ARGV[0].to_i).find_nmax
    end

    attr_accessor :limit
    attr_accessor :digits_array
    attr_accessor :result_array
    attr_accessor :input

    def find_nmax
      input.each_char { |char| process char }
      try_add_result
      result_array
    end

    private

    def initialize(limit)
      self.limit = limit
      self.digits_array = []
      self.result_array = []
      self.input = STDIN
    end

    def process(char)
      if char =~ /[0-9]/
        digits_array.push char.to_i
      else
        try_add_result
      end
    end

    def try_add_result
      unless digits_array.empty?
        add_result digits_array.join.to_i
        digits_array.clear
      end
    end

    def add_result(number)
      result_array.push(number)
      result_array.sort!
      result_array.shift if result_array.size > limit
    end
  end
end
