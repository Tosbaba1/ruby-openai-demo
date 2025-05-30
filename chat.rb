# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

line_width = 50

puts "Hello! How can I help you today?"
puts "-" * line_width
#Building message history

message_list = [
      {
        "role" => "system",
        "content" => "You are a helpful assistant who talks like Barack Obama."
      }
    ]

#Getting input

print ">"
user_input = gets.chomp.strip.downcase

while user_input != "bye"
  if user_input.empty? == false
    # Response
    message_list.push(
      {
        "role" => "user",
        "content" => "#{user_input}"
      }
    )

    # Call the API to get the next message from GPT and send full conversation so far
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    reply = response.dig("choices", 0, "message", "content")
    puts "Chat: #{reply}"
    puts "-" * line_width

    #Add reply to history
    message_list.push({"role" => "assistant", "content" => reply })
  end

  print ">"
  user_input = gets.chomp.strip.downcase
end

puts "Goodbye!"
puts "-" * line_width
