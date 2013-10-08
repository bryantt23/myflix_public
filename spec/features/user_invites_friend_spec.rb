require 'spec_helper'

feature "user invites friend" do
  scenario "user send email invitation, and friend registers", { js: true, vcr: true } do
    # Stripe::Charge.stub(:create)
    josh = User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh")
    login(josh)

    visit new_invite_path
    fill_in "Friend's Name", with: "John Doe"
    fill_in "Friend's Email Address", with: "john@example.com"
    fill_in "Message", with: "Join this site!"
    click_button "Send Invitation"
    logout(josh)

    open_email "john@example.com"
    current_email.click_link("Accept this invitation")

    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2017", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("You registered!")

    open_email "john@example.com"
    expect(current_email).to have_content("Welcome to Myflix.com")
    click_link "People"
    expect(page).to have_content(josh.full_name)
    logout(User.last)

    login(josh)
    click_link "People"
    expect(page).to have_content(User.last.full_name)

    clear_email
  end
end
