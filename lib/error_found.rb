class ErrorFound
  attr_accessor :indent, :open_tag, :close_tag, :angle_bracket

  def initialize
    @angle_bracket = []
    @indent = []
    @open_tag = Hash.new(0)
    @close_tag = Hash.new(0)
  end

end