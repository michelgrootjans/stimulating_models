require 'json'

message = { pong: 1}

File.open("generated/message.json","w") do |f|
  f.write(message.to_json)
end

file = File.read("message.json")
puts "This is the content of the file:"
puts JSON.parse(file)