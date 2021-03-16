module FacilitiesHelper
  def get_icon(facility)
    case facility
    when 'wifi'
      '<i class="fad fa-wifi"></i>'.html_safe
    when 'priv_kitchen'
      '<i class="fad fa-oven"></i>'.html_safe
    when 'gym'
      '<i class="far fa-dumbbell"></i>'.html_safe
    end
  end
end
