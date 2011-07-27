if Rails.env.production?
  MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10075, { :logger => Rails.logger })
  MongoMapper.database = 'app646939'
  MongoMapper.database.authenticate('jalvarezsamayoa', 'Bless777')
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  MongoMapper.database = "eforogt"
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end
