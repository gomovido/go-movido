class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms privacy cookies how_it_works about pricing homepage_2 homepage_3 homepage_4 homepage_5 homepage_6 homepage_7 thank_you]
  before_action :setup_homepage, only: %i[home homepage_2 homepage_3 homepage_4 homepage_5 homepage_6 homepage_7]
  def home
  end

  def privacy; end

  def cookies; end

  def terms; end

  def how_it_works; end

  def pricing; end

  def about; end

  def thank_you; end

  def homepage_3; end

  def homepage_4; end

  def homepage_5; end

  def homepage_6; end

  def homepage_7; end

  def homepage_2; end

  def dashboard
    redirect_to onboarding_path if Order.where(user: current_user, state: 'succeeded').blank?
    @orders = Order.where(state: "succeeded", user: current_user).includes([:shipping])
  end


  def setup_homepage
    @lead = Lead.new
    @companies_logo_urls = ['https://res.cloudinary.com/go-movido-com/image/upload/v1615298087/Company%20logos/revolut_sito9h.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/ee_dx8c5s.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298088/Company%20logos/transferwise_uauj31.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1625068211/Company%20logos/bouygues_ggq0hx.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621532485/Company%20logos/british-telecom_k4rxfr.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/luko_v2mnki.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298089/Company%20logos/uniplaces_f1xg2s.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530813/Company%20logos/uniacco_k1prjs.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/garant-me_xswnji.png']
  end
end
