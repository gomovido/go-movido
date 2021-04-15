module ApplicationHelper
  include Pagy::Frontend

  def pagy_url_for(page, pagy)
    params = request.query_parameters.merge(only_path: true, controller: 'flats', action: 'index', location: pagy.vars[:location], type: pagy.vars[:type], pagy.vars[:page_param] => page)
    url_for(params)
  end
end
