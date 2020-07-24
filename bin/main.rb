require_relative '../lib/files'
require_relative '../lib/line_methods.rb'
require_relative '../lib/error_found'
require 'tmpdir'
require 'io/console'
include LineMethods

ident = 0

def get_files
  dir_files = `ls`.split("\n")
  html_arr = []
  dir_files.each do |item|
  html_arr << item if item[-5..-1] == '.html'
  end
  html_arr
end
#these are my files name and I have to get the lines of each one
files_validation = []
get_files.each do |item|
  tempfilename = File.join(Dir.tmpdir, 'temporary')
  tempfile = File.new(tempfilename, 'w')
  file_lines = IO.readlines(item)
  new_file = ObjectFile.new(item, ident)
  file_lines.each_with_index do |line, i|
    # my_file.doctype(line, idx)
    # my_file.find_angle_brackets(line, idx)
    new_file.check_angle_brackets(line, i + 1)
    line.gsub!("\n", " #{i + 1}\n")
    line.gsub!('>', "> #{i + 1}\n")
    tempfile.syswrite(line)
  end
  if new_file.errors.angle_bracket.empty?
    temp_lines = IO.readlines(tempfile)
    temp_lines.each do |line|
      new_file.check_line(line)
    end
  end
  files_validation << new_file
  tempfile.close
  File.delete(tempfilename)
end

files_validation.each do |check_file|
check_file.errors.angle_bracket.each do |v|
  puts v
end
check_file.check_unclosed_tags
check_file.errors.open_tag.each do |_v, i|
  puts i
end
check_file.errors.close_tag.each do |_v, i|
  puts i
end
check_file.errors.ident.each do |v|
  puts v
end
puts '============================================='
puts "TOTAL ERRORS FOUND #{check_file.error_number} AT FILE #{check_file.file_name}"
puts 'FIX ANGLE BRACKETS TO CHECK OTHER ERRORS' unless check_file.errors.angle_bracket.empty?
puts '============================================='
end

