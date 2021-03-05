class Forest::MobilesController < ForestLiana::SmartActionsController


  def create_features_translations
    mobile = Mobile.find(ForestLiana::ResourcesGetter.get_ids_from_request(params).first)
    attrs = params.dig('data', 'attributes', 'values')
    name_en = attrs['Name (english)']
    description_en = attrs['Description (english)']
    product_feature = ProductFeature.create!(name: name_en, description: description_en, locale: 'en', mobile: mobile)
    name_fr = attrs['Name (french)']
    description_fr = attrs['Description (french)']
    product_feature.update!(name: name_fr, description: description_fr, locale: 'fr')
    render json: { success: 'Translations are successfully implemented.' }
  end
  def create_offers_translations
    mobile = Mobile.find(ForestLiana::ResourcesGetter.get_ids_from_request(params).first)
    attrs = params.dig('data', 'attributes', 'values')
    name_en = attrs['Name (english)']
    special_offer = SpecialOffer.create!(name: name_en, locale: 'en', mobile: mobile)
    name_fr = attrs['Name (french)']
    special_offer.update!(name: name_fr, locale: 'fr')
    render json: { success: 'Translations are successfully implemented.' }
  end
end
