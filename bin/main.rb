require_relative '../lib/files'
require_relative '../lib/line_methods.rb'
require 'tmpdir'
require 'io/console'
include LineMethods

indentation = 0

def get_files
  dir_files = `ls`.split("\n")
  html_arr = []
  dir_files.each do |item|
  html_arr << item if item[-5..-1] == '.html'
  end
  html_arr
end
#these are my files name and I have to get the lines of each one
code_arr = []
get_files.each do |item|
  files_name = File.join(Dir.tmpdir, 'temporary')
  tempfile = File.new(files_name, 'w')
  file_lines = IO.readlines(item)
  my_file = ObjectFile.new(item, indentation)
  file_lines.each_with_index do |line, idx|
    my_file.doctype(line, idx)
    my_file.find_angle_brackets(line, idx)
    code_arr << find_tag(line)
  end
end
