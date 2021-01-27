class IbanApiService

  def initialize(params)
    @iban = params[:iban]
    @uri = URI('https://api.iban.com/clients/api/v4/iban/')
  end

  def api_call
    Net::HTTP.post_form(@uri, "format" => "json", "api_key" => Rails.application.credentials.production[:iban_api][:api_key], "iban" => @iban).body
  end
end
