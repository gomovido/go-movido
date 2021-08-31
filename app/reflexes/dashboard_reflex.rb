class DashboardReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def payment_details(arg)
    @cards = arg['sources']['data']
    @default_source = arg['default_source']
    morph '.cards-wrapper', render(partial: "payment_details/cards", locals: { cards: @cards, default_source: @default_source } )
  end
end
