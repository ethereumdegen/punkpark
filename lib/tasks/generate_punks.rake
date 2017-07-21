


require 'jimson'


desc 'get_punk_owners_from_jsonrpc'
task get_punk_owners_from_jsonrpc: :environment do
  client = Jimson::Client.new("localhost:4040") # the URL for the JSON-RPC 2.0 server to connect to
  result = client.add(1,2) # call the 'sum' method on the RPC server and save the result '3'
  p result

end


desc 'get_punk_owners_from_jsonrpc'
task regenerate_punks: :environment do

    Punk.destroy_all

   (0..99).each do |punk_id|
     punk = Punk.new(id: punk_id)
     punk.save!
     p 'saved punk ' + punk_id
   end

end
