class Forest::Mobile
  include ForestLiana::Collection

  collection :Mobile

  action 'Create mobile features translations', type: 'single', fields: [{
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
  action 'Create mobile offers translations', type: 'single', fields: [{
    field: 'Name (english)',
    type: 'String',
    is_required: true
  }, {
    field: 'Name (french)',
    type: 'String',
    is_required: true
  }]
end
