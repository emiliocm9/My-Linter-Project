
def get_files
  dir_files = `ls`.split("\n")
  html_arr = []
  dir_files.each do |item|
  html_arr << item if item[-5..-1] == '.html'
  end
  p html_arr
end

get_files