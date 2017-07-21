


require 'jimson'


desc 'get_punk_owners_from_jsonrpc'
task get_punk_owners_from_jsonrpc: :environment do
  client = Jimson::Client.new("localhost:4040") # the URL for the JSON-RPC 2.0 server to connect to
  result = client.add(1,2) # call the 'sum' method on the RPC server and save the result '3'
  p result

end
