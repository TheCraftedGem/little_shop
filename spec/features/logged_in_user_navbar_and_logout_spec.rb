require 'rails_helper'

describe "the user navbar options" do
  scenario "when registered you get a functional account dropdown and can logout" do

    visit '/'

    click_on 'Register'

    expect(current_path).to eq(new_user_path)
    fill_in :user_email_address, with: "isaac@email.com"
    fill_in :user_password, with: 'test1234'
    fill_in :user_first_name, with: "Isaac"
    fill_in :user_last_name, with: 'Falkenstine'
    fill_in :user_street_address, with: "1234 Coral Ln."
    fill_in :user_city, with: 'Denver'
    fill_in :user_zip, with: 12345
    fill_in :user_state, with: 'Colorado'

    click_on 'Create User'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content("Welcome #{User.last.first_name} to the Pubshop App!")
    expect(page).to have_content("Welcome, #{User.last.first_name} #{User.last.last_name}")

    click_on "Account"
    expect(page).to have_content("Profile")
    expect(page).to have_content("Orders")

    click_on "Logout"
    expect(current_path).to eq("/")
    expect(page).to have_content("You have been logged out")
    expect(page).to have_content("Login")
  end

end
