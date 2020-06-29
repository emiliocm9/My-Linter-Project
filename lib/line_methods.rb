module LineMethods
  require 'strscan'

  def split_line
    self.split('')
  end

  def get_angles(line)
    angle_brackets = []
    line.split_line.each do | item |
      if item == '<' || item == '>'
        angle_brackets << item
      end
    end
    return angle_brackets
  end

  def find_tag(line)
    s = StringScanner.new(line)
    b = s.scan_until />/
    b.delete!('>')
    tag_bracket = b.delete!('<')
    tag = tag_bracket.split(' ')[0]
    tag
  end

  def angle_brackets_check(line, idx)
    a = get_angles(line)
    if a.length.odd?
      "Error: form line #{idx + 1}. A slash was not immediately followed by '>'"
    end
  end

  def doctype_check(index)
    if !self.include?('<!DOCTYPE html>')
      "Error: form line #{index + 1}. Start tag seen without seeing a doctype first. Expected <!DOCTYPE html>"
    elsif self.include?('<!DOCTYPE html>') && index == 1
      "Error: form line #{index + 1}. Empty line at the top of the document. Expected <!DOCTYPE html> at top"
    end
  end

  def check_angle_brackets(line, index)
    bracket_stack = []
    line.split('').each do |n, i|
      if n == '<'
        if bracket_stack.length.zero?
          bracket_stack << n
        else
          create_error_bracket_inside(index, i)
          return nil
        end
      end
      bracket_stack.pop if n == '>' && bracket_stack.size == 1
      
    end
    create_error_bracket_unclosed(index) unless bracket_stack.size.zero?
  end

  def create_error_bracket_inside(index, col)
    @error_number += 1
    @errors.angle_bracket.push("Line #{index} with angle bracket (<) open inside another angle bracket at col #{col}")
  end

  def create_error_bracket_unclosed(index, col)
    @error_number += 1
    @errors.angle_bracket.push("Line #{index} should have all angle bracket (<) closed with a matching #{col}")
  end
  
end