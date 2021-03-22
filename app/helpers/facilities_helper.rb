module FacilitiesHelper
  def get_provider(flat_category)
    case flat_category
    when 'flatshare'
      'uniacco'
    when 'entire_place'
      'uniplaces'
    when 'student_housing'
      'homelike'
    end
  end

  def get_icon(facility)
    case facility
    when 'wifi'
      '<i class="fad fa-wifi"></i>'.html_safe
    when 'priv_kitchen'
      '<i class="fad fa-oven"></i>'.html_safe
    when 'gym'
      '<i class="far fa-dumbbell"></i>'.html_safe
    when 'bed'
      '<i class="far fa-bed"></i>'.html_safe
    when 'shower'
      '<i class="fad fa-shower"></i>'.html_safe
    when 'kitchen'
      '<i class="far fa-refrigerator"></i>'.html_safe
    when 'room-type'
      '<i class="fad fa-key"></i>'.html_safe
    when 'wardrobe'
      '<i class="fad fa-tshirt"></i>'.html_safe
    when 'endstudy-desk'
      '<i class="fal fa-lamp-desk"></i>'.html_safe
    when 'window'
      '<i class="far fa-blinds-open"></i>'.html_safe
    when 'room-cleaning'
      '<i class="far fa-vacuum"></i>'.html_safe
    when 'uf-heating'
      '<i class="fad fa-heat"></i>'.html_safe
    when 'room-size'
      '<i class="fal fa-cube"></i>'.html_safe
    when 'study-desk'
      '<i class="fal fa-chair-office"></i>'.html_safe
    when 'double-bed'
      '<i class="far fa-people-arrows"></i>'.html_safe
    when 'underbed-storage'
      '<i class="fad fa-box-open"></i>'.html_safe
    end
  end

  def get_name(facility)
    case facility
    when 'Small Double Bed'
      'Double bed'
    when 'Private Bathroom'
      'Bathroom'
    when 'Private Kitchen'
      'Kitchen'
    when 'Study desk and chair'
      'Study Desk'
    when 'Dual Occupancy Available'
      'Roommates'
    when 'Queen Size Bed'
      'Double Bed'
    when 'Room Cleaning Services'
      'Cleaning'
    when 'Underfloor Heating'
      'Heater'
    when 'Windows / Curtains'
      'Windows'
    else
      facility
    end
  end

  def split_description(description)
    "#{ActionView::Base.full_sanitizer.sanitize(description).html_safe.first(100)}..."
  end

  def full_description(description)
    ActionView::Base.full_sanitizer.sanitize(description).gsub(/\. /, '.<br><br>').html_safe
  end
end
