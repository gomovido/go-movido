module Forest
  class Wifi
    include ForestLiana::Collection

    collection :Wifi

    action 'Create wifi features translations', type: 'single', fields: [{
      field: 'Name (english)',
      type: 'String',
      is_required: true
    }, {
      field: 'Description (english)',
      type: 'String',
      is_required: true
    }, {
      field: 'Name (french)',
      type: 'String',
      is_required: true
    }, {
      field: 'Description (french)',
      type: 'String',
      is_required: true
    }]
    action 'Create wifi offers translations', type: 'single', fields: [{
      field: 'Name (english)',
      type: 'String',
      is_required: true
    }, {
      field: 'Name (french)',
      type: 'String',
      is_required: true
    }]
  end
end
