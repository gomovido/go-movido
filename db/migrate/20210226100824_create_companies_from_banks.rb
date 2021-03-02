class CreateCompaniesFromBanks < ActiveRecord::Migration[6.0]
  def change
    Bank.find_by(name: 'TransferWise').update(logo_url: 'https://i.ibb.co/1RJ7znV/transferwise.png')
    Bank.find_by(name: 'Bunq').update(logo_url: 'https://i.ibb.co/3T68CLZ/bunq.png', affiliate_link: 'https://www.getbunq.app/2PD3H1C/225JFQ/?uid=3&source_id=www.go-movido.com')
    Bank.all.each do |bank|
      company = Company.create(name: bank.name, logo_url: bank.logo_url)
      bank.update(company: company)
    end
  end
end
