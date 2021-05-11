module FacilitiesHelper
  PROVIDERS = {
    'flatshare' => 'uniplaces',
    'entire_flat' => 'uniplaces',
    'student_housing' => 'uniacco'
  }

  def split_description(description)
    description ? "#{ActionView::Base.full_sanitizer.sanitize(description).first(200)}..." : 'Lorem ipsum dolor sit amet,  consectetur adipiscing elit consectetur adipiscing elit consectetur adipiscing elit...'
  end

  def full_description(description)
    description ? ActionView::Base.full_sanitizer.sanitize(description).gsub(/\. /, '.<br><br>') : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consectetur facilisis lorem. Proin sit amet viverra velit. Proin semper auctor convallis. Integer turpis leo, rutrum elementum scelerisque non, molestie non massa. Morbi commodo fermentum lectus, ut blandit nunc pretium sollicitudin. Aliquam nunc metus, rhoncus in purus sit amet, fermentum volutpat arcu. Mauris imperdiet nulla quis luctus molestie'
  end
end
