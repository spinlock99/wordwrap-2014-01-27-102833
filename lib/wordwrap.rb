class WordWrap
  def initialize(wrap_column)
    unless wrap_column.class.ancestors.include?(Integer)
      raise Exception.new("expected Integer got #{wrap_column.class}")
    end
    @wrap_column = wrap_column
  end

  def wrap(text)
    unless text.class.ancestors.include?(String)
      raise Exception.new("expected String got #{text.class}")
    end

    next_wrap = @wrap_column
    index = 0

    text.each_char do |char|
      @last_space = index if char.match(/\s/)
      if index >= next_wrap
        if @last_space
          text[@last_space] = "\n"
          next_wrap = @wrap_column + @last_space + 1
        else
          text.insert(next_wrap, "\n")
          next_wrap += @wrap_column + 1
          index += 1
        end
        @last_space = nil
      end
      index += 1
    end
  end
end
