require 'sidekiq'
require 'sidekiq-scheduler'

class MarketingScheduler
  include Sidekiq::Worker

  def perform
    MarketingEmailsJob.perform_later
  end
end
