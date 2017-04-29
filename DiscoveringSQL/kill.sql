production:
   url: <%= DATABASE_URL %>
   variables:
     statement_timeout: 5000
     
class MyAnalyticsJob < ActiveJob::Base
  queue_as :analytics
  def perform
    ActiveRecord::Base.connection.execute “SET statement_timeout = 600000” # 10 minutes
    # ...
  ensure
    ActiveRecord::Base.connection.execute “SET statement_timeout = 5000” # 5 seconds
  end
end

Account Load (0.3ms)  SELECT `accounts`.* FROM `accounts` 
WHERE `accounts`.`queenbee_id` = 1234567890 
LIMIT 1 
/*application:BCX,controller:project_imports,action:show*/
