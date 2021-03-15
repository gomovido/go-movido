module Forest
  class ProductFeature
    include ForestLiana::Collection

    collection :ProductFeature

    action 'To the top', type: 'single'
  end
end
