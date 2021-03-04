class Forest::Mobile
  include ForestLiana::Collection

  collection :Mobile

  action 'Create mobile features translations', type: 'single', fields: [{
    field: 'Name',
    type: 'String',
    is_required: true
  }, {
    field: 'Description',
    type: 'String',
    is_required: true
  }, {
    field: 'Language',
    type: 'Enum',
    enums: ['fr', 'en'],
    is_required: true
  }]
  action 'Create mobile offers translations', type: 'single', fields: [{
  field: 'Name',
  type: 'String',
  is_required: true
}, {
  field: 'Language',
  type: 'Enum',
  enums: ['fr', 'en'],
  is_required: true
}]
end
