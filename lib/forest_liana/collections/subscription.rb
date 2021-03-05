class Forest::Subscription
  include ForestLiana::Collection

  collection :Subscription

  action 'Activate subscription'
end
