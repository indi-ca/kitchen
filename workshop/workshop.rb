

class Workshop


end

puts "Hello"


arr = [1, 2, 3 , 4]
puts arr

=begin
bob = {
    'k' : 'v',
    'k2' : 'v2'
}
=end


baaz = { "a" => 10, "b" => 17, "z" => 42 }

baaz.each do |x|
  puts x
end


databags_path = '../data_bags_source'
puts File.exists?(databags_path)
puts File.directory?(databags_path)


something = Dir.open(databags_path)
#something.each do |f|
#  print f
#end
print something

