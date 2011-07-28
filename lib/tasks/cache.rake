namespace :cache do
  desc 'Clear memcache'
  task :clear => :environment do
    Rails.cache.clear
    CACHE.flush
  end
end
