namespace :creeper do
  task :look => :environment do
    puts "a creeper coming! at #{Time.now.localtime.to_s :db }"
    UrlFinderJob.perform_later
  end
end
