class Forest::Wifi
  include ForestLiana::Collection

  collection :Wifi

  action 'Create wifi features translations', type: 'single', fields: [{
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
  action 'Create wifi offers translations', type: 'single', fields: [{
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
