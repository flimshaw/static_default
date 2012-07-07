project_name = File.basename(Dir.getwd)

# deploy script for copying to staging server
namespace :staging do
  task :deploy, :ssh_user do |t, args|
    ssh_user = args[:ssh_user]
    staging_server = "staging.charliehoey.com"
    staging_root = "#{remote_server}/#{project_name}/"
    puts "*** Compiling Coffeescript ***"
    system("coffee -o source/javascripts/ -c source/javascripts/")
    system("middleman build --relative")
    rsync = "rsync -avz --delete build/ #{ssh_user}@#{staging_server}:#{staging_root}"
    puts rsync
    system(rsync)
    puts "*** DONE! ***"
  end
end

# deploy script for copying to production server
namespace :production do
  task :deploy, :ssh_user do |t, args|
    ssh_user = args[:ssh_user]
    production_server = "staging.charliehoey.com"
    production_root = "#{remote_server}/staging_root/"
    puts "*** Compiling Coffeescript ***"
    system("coffee -o source/javascripts/ -c source/javascripts/")
    system("middleman build --relative")
    rsync = "rsync -avz --delete build/ #{ssh_user}@#{production_server}:#{production_root}"
    puts rsync
    system(rsync)
    puts "*** DONE! ***"
  end
end

# local actions
namespace :local do 
  
  # start sinatra server
  task :server do |t, args|
    puts "*** Starting server... ***"
    system('ruby -rubygems config.rb')
    puts "*** Done! ***"
  end

  # start coffeescript server
  task :coffee do |t, args|
    puts "*** Starting coffeescript watcher ***"
    system('coffee -o public/js/src/ --join app.js -cw app/default/coffeescripts/models.coffee app/default/coffeescripts/collections.coffee app/default/coffeescripts/views.coffee app/default/coffeescripts/util.coffee app/default/coffeescripts/routers.coffee app/default/coffeescripts/app.coffee & coffee -o public/js/spec/ -cw app/default/coffeescripts/spec/ &')
    puts "*** Done! ***"
  end

  # start bunch
  task :bunch do |t, args|
    puts "*** Bunch ***"
    system('bunch monitor')
    puts "*** Done! ***"
  end

end
