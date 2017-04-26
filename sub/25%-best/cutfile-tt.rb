fileja_in = File.open ARGV[0], "r"
fileja_out1 = File.open "turn.ja", "w"
fileja_out3 = File.open "train.ja", "w"
filevi_in = File.open ARGV[1], "r"
filevi_out1 = File.open "turn.vi", "w"
filevi_out3 = File.open "train.vi", "w"

class Couper 
  attr_reader :ja, :vi
  def initialize(ja, vi)
    @ja = ja
    @vi = vi
  end

  def ja
    @ja
  end

  def vi
    @vi
  end
end

def make_file(data, fileja_out, filevi_out, make_line = 0)
  if make_line == 0
    data.each do |couper|
      filevi_out.print couper.vi
      fileja_out.print couper.ja
    end
  else
    counter = 0
    until counter >= make_line
      counter += 1
      filevi_out.print data.first.vi
      fileja_out.print data.first.ja
      data.delete data.first
      puts "#{counter}/#{data.size}"
    end
  end
end

data = Array.new
puts "loading ... data"
fileja_in.each.zip(filevi_in.each).each do |ja, vi|
  couper = Couper.new(ja, vi)
  data << couper
end
puts "loaded data successfully"
data.shuffle!
turn = data.size*2/9

puts "making ... file turn"
make_file(data, fileja_out1, filevi_out1, turn)
puts "making ... file train"
make_file(data, fileja_out3, filevi_out3)
