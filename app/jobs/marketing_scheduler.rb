require 'sidekiq'
require 'sidekiq-scheduler'

class MarketingScheduler
  include Sidekiq::Worker

  def perform
    OrderMarketingEmailsJob.perform_later
    UserMarketingEmailsJob.perform_later
  end
end
