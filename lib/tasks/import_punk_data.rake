

##delete all punks

##import all punks



namespace :db do

  desc 'import_punk_data'
  task import_punk_data: :environment do

    import_punk_data

  end


  def import_punk_data
         p 'starting punk import '



  end




end
