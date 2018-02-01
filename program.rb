require 'json'

message = { pong: 1}

File.open("message.json","w") do |f|
  f.write(message.to_json)
end