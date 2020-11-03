module ApplicationHelper

  def blue_bg_is_active?
    controller_name != "pages" && action_name != 'home'
  end

end
