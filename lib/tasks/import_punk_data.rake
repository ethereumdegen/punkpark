

##delete all punks

##import all punks



namespace :db do

  desc 'import_punk_data'
  task import_punk_data: :environment do

    import_punk_data

  end


  def import_punk_data
         p 'starting punk import '
         client = Jimson::Client.new("localhost:4040") # the URL for the JSON-RPC 2.0 server to connect to

          p 'client launch '

         (0..10000).each do |punk_id|
           p 'meep '
           result = client.getPunkOwner(punk_id) # call the 'sum' method on the RPC server and save the result '3'
           p punk_id
           p result

           
         end



  end




end
