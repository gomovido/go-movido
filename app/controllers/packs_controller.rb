class PacksController < ApplicationController

  def index
    @messages = [{ content: "Amazing! Please wait a few seconds  as I put together your customized pack.", delay: 0 }, { content: 'Thanks for waiting, please find your customized pack below.', delay: '3' }]
  end
end
