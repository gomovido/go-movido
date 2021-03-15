# rubocop:disable Style/ClassAndModuleChildren
class Forest::ProductFeaturesController < ForestLiana::SmartActionsController
  # rubocop:enable Style/ClassAndModuleChildren
  def to_the_top
    product_feature_id = ForestLiana::ResourcesGetter.get_ids_from_request(params).first
    product_feature = ProductFeature.find(product_feature_id)
    product = product_feature.mobile || product_feature.wifi
    ordered_pfs = product.product_features.order(order: :asc)
    actual_feature_index = ordered_pfs.index(product_feature)
    if product_feature == ordered_pfs.first
      render json: { success: "This product feature is already on the very top" }
    else
      actual_feature_order = product_feature.order
      to_change_feature_order = ordered_pfs[actual_feature_index - 1].order
      product_feature.update!(order: to_change_feature_order)
      ordered_pfs[actual_feature_index - 1].update!(order: actual_feature_order)
      render json: { success: "Positioning changed" }
    end
  end
end
