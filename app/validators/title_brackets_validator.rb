class TitleBracketsValidator < ActiveModel::Validator

    BRACKETS = { "(" => ")", "{" => "}", "[" => "]"}
  
    def validate(record)
      stack = []
      previous_char = ''

      record.title.each_char do |char|
        stack << char if BRACKETS.key?(char)
        
        return add_errors(record) if BRACKETS[previous_char] == char
        
        previous_char = char
        return add_errors(record) if BRACKETS.key(char) && BRACKETS.key(char) != stack.pop
      end
    add_errors(record) unless stack.empty?
    end

    private

    def add_errors(record)
      record.errors[:title] << "invalid"
    end
  end
