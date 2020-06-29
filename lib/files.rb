require_relative 'line_methods'
require_relative 'error_found'
include LineMethods

class ObjectFile
  attr_reader :file_name

    def initialize(file, indentation)
      @file_name = file
      @indentation = indentation
      @open_tag_hash = Hash.new([])
      @index_open = 0
      @index_close = 0
      @index_line = 1
      @space_id = 0
      @errors = ErrorFound.new
      @error_number = 0
      @root_element = ''
      @closed_root =  find_angle_brackets
      @tried_close_more_roots = false
      @last_close_key = ''
    end

    def check_unclosed_tags
      @open_tag_hash.each do |n|
        @error_number += 1
        @errprs

    def doctype(line, idx)
      if idx == 0 && !line.include?('<!DOCTYPE html>')
        puts "In #{@file_name} #{line.doctype_check(idx)}"
      elsif idx == 1 &&line.include?('<!DOCTYPE html>')
        puts "In #{@file_name} #{line.doctype_check(idx)}"
      end
    end

    def check_indentation(line)
    end 

    def find_angle_brackets(line, idx)
      a = get_angles(line)
      str = "Error: form line #{idx + 1}. A slash was not immediately followed by '>'"
      if a.length.odd?
        puts "In #{@file_name} #{str}"
      end
    end
    

end
