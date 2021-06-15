class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms privacy cookies how_it_works about]
  def home
    @lead = Lead.new
    @companies_logo_urls = ['https://res.cloudinary.com/go-movido-com/image/upload/v1615298087/Company%20logos/revolut_sito9h.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/ee_dx8c5s.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298088/Company%20logos/transferwise_uauj31.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298088/Company%20logos/bouygues_telecom_wcouac.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621532485/Company%20logos/british-telecom_k4rxfr.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/luko_v2mnki.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298089/Company%20logos/uniplaces_f1xg2s.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530813/Company%20logos/uniacco_k1prjs.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/garant-me_xswnji.png']
  end

  def privacy; end

  def cookies; end

  def terms; end

  def how_it_works; end

  def about; end

  def dashboard
    @orders = Order.where(state: "succeeded", user: current_user).includes([:shipping])
  end
end
