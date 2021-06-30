class CalculatorReflex < ApplicationReflex

  def updateCountry
    morph '.checkboxes-banner', render(partial: "shared/components/checkboxes", locals: {country: Country.find_by(code: element.values[0])})
  end
end
