require_relative 'line_methods'
include LineMethods

class ObjectFile
  attr_reader :file_name

    def initialize(file, indentation)
      @file_name = file
      @indentation = indentation
    end

    def doctype(line, idx)
      if idx == 0 && !line.include?('<!DOCTYPE html>')
        puts "In #{@file_name} #{line.doctype_check(idx)}"
      elsif idx == 1 &&line.include?('<!DOCTYPE html>')
        puts "In #{@file_name} #{line.doctype_check(idx)}"
      end
    end

    def find_angle_brackets(line, idx)
      a = get_angles(line)
      str = "Error: form line #{idx + 1}. A slash was not immediately followed by '>'"
      if a.length.odd?
        puts "In #{@file_name} #{str}"
      end
    end
    

end
