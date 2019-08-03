require "application_system_test_case"

class ShorturlsTest < ApplicationSystemTestCase
  setup do
    @shorturl = shorturls(:one)
  end

  test "visiting the index" do
    visit shorturls_url
    assert_selector "h1", text: "Shorturls"
  end

  test "creating a Shorturl" do
    visit shorturls_url
    click_on "New Shorturl"

    click_on "Create Shorturl"

    assert_text "Shorturl was successfully created"
    click_on "Back"
  end

  test "updating a Shorturl" do
    visit shorturls_url
    click_on "Edit", match: :first

    click_on "Update Shorturl"

    assert_text "Shorturl was successfully updated"
    click_on "Back"
  end

  test "destroying a Shorturl" do
    visit shorturls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shorturl was successfully destroyed"
  end
end
