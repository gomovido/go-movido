FactoryBot.define do
  factory :subscription do
    state { "draft" }
    delivery_address { "57 Rue Sedaine, Paris 11e Arrondissement, Île-de-France, France" }
    sim { "Nano" }
    contact_phone { "+33767669504" }
  end
end
