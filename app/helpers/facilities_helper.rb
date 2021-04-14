module FacilitiesHelper
  PROVIDERS = {
    'flatshare' => 'homelike',
    'entire_flat' => 'uniplaces',
    'student_housing' => 'uniacco'
  }

  def split_description(description)
    "#{ActionView::Base.full_sanitizer.sanitize(description).first(200)}..."
  end

  def full_description(description)
    ActionView::Base.full_sanitizer.sanitize(description).gsub(/\. /, '.<br><br>')
  end
end
