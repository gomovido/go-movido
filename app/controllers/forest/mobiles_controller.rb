class Forest::MobilesController < ForestLiana::SmartActionsController


  def create_features_translations
    mobile = Mobile.find(ForestLiana::ResourcesGetter.get_ids_from_request(params).first)
    attrs = params.dig('data', 'attributes', 'values')
    name = attrs['Name']
    description = attrs['Description']
    locale = attrs['Language']
    ProductFeature.create(name: name, description: description, locale: locale, mobile: mobile)
    render json: { success: 'Translations are successfully implemented.' }
  end
  def create_offers_translations
    mobile = Mobile.find(ForestLiana::ResourcesGetter.get_ids_from_request(params).first)
    attrs = params.dig('data', 'attributes', 'values')
    name = attrs['Name']
    locale = attrs['Language']
    SpecialOffer.create(name: name, locale: locale, mobile: mobile)
    render json: { success: 'Translations are successfully implemented.' }
  end
end
