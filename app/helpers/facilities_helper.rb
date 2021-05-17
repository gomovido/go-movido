module FacilitiesHelper
  PROVIDERS = {
    'flatshare' => 'uniplaces',
    'entire_flat' => 'uniplaces',
    'student_housing' => 'uniacco'
  }

  def split_description(description)
    description ? "#{ActionView::Base.full_sanitizer.sanitize(description).first(200)}..." : 'No description available'
  end

  def full_description(description)
    description ? ActionView::Base.full_sanitizer.sanitize(description).gsub(/\. /, '.<br><br>') : 'No description available'
  end
end
