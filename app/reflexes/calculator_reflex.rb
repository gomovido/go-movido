class CalculatorReflex < ApplicationReflex
  def update_country
    morph '.checkboxes-banner', render(partial: "shared/components/checkboxes", locals: { country: Country.find_by(code: element.values[0]) })
  end
end
