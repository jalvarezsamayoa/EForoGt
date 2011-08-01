namespace :cache do
  desc 'Clear memcache'
  task :clear => :environment do
    FileUtils.rm(Dir['public/javascripts/cache/[^.]*'])
    FileUtils.rm(Dir['public/stylesheets/cache/[^.]*'])
  end
end
