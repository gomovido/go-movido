require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/"
    assert_selector "h1", text: "Get set up\nin your new home\nin only 10 mins"
  end

  test "lets a signed in user create a new address with wrong street" do
    login_as users(:george)
    visit "users/#{User.first.id}/addresses/new"
    fill_in "address_street", with: "test"
    click_on 'Confirm'
    assert_selector ".invalid-feedback", text: "Address is not valid"
  end

  test "lets a signed in user create a new address with valid street" do
    login_as users(:george)
    visit "users/#{User.first.id}/addresses/new"
    fill_in "address_street", with: "57 Rue de Fécamp, Paris 12e Arrondissement, Île-de-France, France"
    find('#address_city', visible: false).execute_script("this.value = 'Paris'")
    find('#address_zipcode', visible: false).execute_script("this.value = '75012'")
    click_on 'Confirm'
    assert_equal root_path, page.current_path
    assert_selector "h1", text: "Select the services you need"
  end
end
