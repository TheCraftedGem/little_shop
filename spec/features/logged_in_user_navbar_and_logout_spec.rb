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
    expect(page).to have_content("Account")

    click_on "Logout"
    expect(current_path).to eq("/")
    expect(page).to have_content("You have been logged out")
    expect(page).to have_content("Login")
  end

  scenario "when youre a merchant you get a dashboard link and can logout" do

    merch_user_1 = User.create(first_name: "Merchant", last_name: "User", street_address: "1234 Sales St.",
                          city: "Lone Tree", state: "Colorado", zip: 81234, email_address: "merchant1@email.com", password: "pass123", role: 1)

    admin_user = User.create(first_name: "Admin", last_name: "User", street_address: "1234 Boss St.",
                           city: "Lone Tree", state: "Colorado", zip: 81234, email_address: "admin@email.com", password: "pass123", role: 2)


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
    expect(page).to have_content("Dashboard")

    click_on "Logout"
    expect(current_path).to eq("/")
    expect(page).to have_content("You have been logged out")
    expect(page).to have_content("Login")
  end


end
