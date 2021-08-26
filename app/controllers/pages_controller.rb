class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms privacy cookies how_it_works about pricing starter_pack settle_in thank_you]
  before_action :setup_homepage, only: %i[home]
  def home
    @logos =
      [
        { url: 'sorbonne_logo' },
        { url: 'ucl_logo' },
        { url: 'revolut_logo' },
        { url: 'escp_logo' },
        { url: 'kings_college_logo' },
        { url: 'bocconi_logo' },
        { url: 'bouygues_telecom_logo' },
        { url: 'bnyou_logo' },
        { url: 'cuckoo_logo' },
        { url: 'total_direct_logo' },
        { url: 'uni_acco_logo' },
        { url: 'uniplaces_logo' }
      ]
    @faqs =
      [{
        question: "How much does it cost?",
        answer: "Prices depend on the products you choose. Most of them <strong>come with credit included</strong>, which is only what you pay - <strong>we do not charge anything on top</strong> for our services. On the contrary, working on a B2B basis with our providers, we can often <strong>even offer great discounts.</strong> Prices for our UK giffgaff SIM card start at £1 for instance. Click on the packs to see more."
      },
       {
         question: "How does it work? ",
         answer: "You can <strong>customize your own packs</strong> - choose what you want and only pay for what you need. The <strong>Starter Pack</strong> is a physical envelope with all pay-as-you go items sent to your current home while the <strong>Settle-in Pack</strong> digitally simply bundles all your subscriptions in 1 monthly bill."
       },
       {
         question: "Who are your providers?",
         answer: "Over time, we have identified the one provider that is best for the respective service. In the UK and France, <strong>we only work with reputable providers</strong> who are ranked top in the industry and provide a very <strong>reliable service</strong> for a <strong>good value-to-money ratio.</strong>"
       }]

    @testimonials = 
      [{
        name: "Karan",
        country: "India",
        destination: "Nice",
        video_link: "cneu8_K140M",
        quote: "Thanks to the Movido Starter Pack, I was 100% ready for my stay in Nice!"
      },
      {
        name: "Menahim",
        country: "Indonesia",
        destination: "London",
        video_link: "9MbXD6UgvvU",
        quote: "Getting WiFi & electricity for my London stay took less than 5 minutes with Movido"
      }]
        
  end

  def privacy; end

  def cookies; end

  def terms; end

  def how_it_works; end

  def pricing; end

  def starter_pack
    @benefits =
      [{
        icon: 'idea',
        content: "<strong>Don’t spend hours searching for the best providers</strong> – we did it for you"
      },
       {
         icon: 'dollar',
         content: "<strong>All offers already come with credit</strong> – use them directly upon arrival"
       },
       {
         icon: 'credit-card',
         content: "Only <strong>one-off payments</strong> without any long-term commitment</span>"
       },
       {
         icon: 'tag',
         content: "<strong>Exclusive discounts</strong> on most offers available only on Movido</span>"
       },
       {
         icon: 'house',
         content: "<strong>Shipped to your current home</strong> worldwide and entirely for free"
       }]
    @slides =
      [{
        title: "Get Started",
        content: "Get started by filling-in only a few necessary details about yourself"
      },
       {
         title: "Choose your offer",
         content: "Select everything you need abroad and benefit from great discounts"
       },
       {
         title: "Wait for your shipment",
         content: "An envelope is directly sent to your current home - worldwide and with free shipping."
       }]
    @faqs =
      [{
        question: "Do I need the full pack?",
        answer: "You can simply <strong>choose the offers that are most relevant to you</strong> - no need to take the entire bundle."
      },
       {
         question: "How does shipping work?",
         answer: "We send our envelopes <strong>worldwide and without any shipping costs.</strong> You can then track your delivery in your dashboard. Depending on your location, shipping can take up to 7 business days - so don’t wait until last minute but get started right away."
       },
       {
         question: "Housing search guarantee?",
         answer: "We do our best to find your dream flat. So far, we have always been able to provide our users with their perfect apartment -  > 1,200 students in Paris and London alone. However, for  €19.90 / £19.90 we simply cannot guarantee it."
       }]
    @services = Pack.find_by(name: 'starter').services.includes([:category])
    @testimonials = 
      [{
        name: "Karan",
        country: "India",
        destination: "Nice",
        video_link: "cneu8_K140M",
        quote: "Thanks to the Movido Starter Pack, I was 100% ready for my stay in Nice!"
      },
      {
        name: "Menahim",
        country: "Indonesia",
        destination: "London",
        video_link: "9MbXD6UgvvU",
        quote: "Getting WiFi & electricity for my London stay took less than 5 minutes with Movido"
      }]
  end

  def settle_in
    @benefits =
      [{
        icon: 'idea',
        content: "<strong>Don’t spend hours searching for the best providers</strong> – we did it for you"
      },
       {
         icon: 'folder',
         content: "Simply select the subscriptions you need <strong>and let us deal with the admin work</strong>"
       },
       {
         icon: 'page-flip',
         content: "Customize your subscription bundle into <strong>1 simple monthly bill</strong>"
       },
       {
         icon: 'tag',
         content: "<strong>Exclusive discounts</strong> on most offers available only on Movido</span>"
       },
       {
         icon: 'chrono',
         content: "<strong>No long-term commitment</strong> - you can cancel anytime you like"
       }]
    @slides =
      [{
        title: "Get Started",
        content: "Get started by filling-in only a few necessary details about yourself"
      },
       {
         title: "Choose your offer",
         content: "Select everything you need abroad and benefit from great discounts"
       },
       {
         title: "1 simple monthly bill",
         content: "Only pay us 1 monthly bill - we take care of all the boring admin stuff. You can also cancel anytime"
       }]
    @faqs =
      [{
        question: "How to cancel contracts",
        answer: "You can <strong>cancel the contract towards the end of each month</strong> - there is no 24-months lock-up as you normally see. Simply write us an email or click on “cancel” in your dashboard and we will do all the admin around your cancellation."
      },
       {
         question: "Do you charge extra fees?",
         answer: "Our most important goal is customer satisfaction and transparency that goes along with it. <strong>The prices you see are what you will pay</strong> - no hidden fees. We do not charge anything extra. So how do we make money? We work on a commission based system - so the provider pays us."
       },
       {
         question: "Who are your providers?",
         answer: "Over time, we have identified the one provider that is best for the respective service. In the UK and France, <strong>we only work with reputable providers</strong> who are ranked top in the industry and provide a very <strong>reliable service</strong> for a <strong>good value-to-money ratio.</strong>"
       }]
    @services = Pack.find_by(name: 'settle_in').services.includes([:category])
    @testimonials = 
      [{
        name: "Karan",
        country: "India",
        destination: "Nice",
        video_link: "cneu8_K140M",
        quote: "Thanks to the Movido Starter Pack, I was 100% ready for my stay in Nice!"
      },
      {
        name: "Menahim",
        country: "Indonesia",
        destination: "London",
        video_link: "9MbXD6UgvvU",
        quote: "Getting WiFi & electricity for my London stay took less than 5 minutes with Movido"
      }]
  end

  def about; end

  def thank_you; end

  def setup_homepage
    @lead = Lead.new
    @companies_logo_urls = ['https://res.cloudinary.com/go-movido-com/image/upload/v1615298087/Company%20logos/revolut_sito9h.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/ee_dx8c5s.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298088/Company%20logos/transferwise_uauj31.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1625068211/Company%20logos/bouygues_ggq0hx.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621532485/Company%20logos/british-telecom_k4rxfr.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/luko_v2mnki.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298089/Company%20logos/uniplaces_f1xg2s.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530813/Company%20logos/uniacco_k1prjs.png', 'https://res.cloudinary.com/go-movido-com/image/upload/v1621530529/Company%20logos/garant-me_xswnji.png']
  end

end
