class IbanApiService

  def initialize(params)
    @iban = params[:iban]
    @sort_code = params[:sort_code]
    @account_number = params[:account_number]
  end

  def check_iban
    uri = URI('https://api.iban.com/clients/api/v4/iban/')
    Net::HTTP.post_form(uri, "format" => "json", "api_key" => Rails.application.credentials.production[:iban_api][:api_key], "iban" => @iban).body
  end

  def calculate_iban
    uri = URI('https://api.iban.com/clients/api/calc-api.php')
    Net::HTTP.post_form(uri, "format" => "json", "api_key" => Rails.application.credentials.production[:iban_api][:api_key], "country" => "GB", "bankcode" => @sort_code, "account" => @account_number).body
  end
end
