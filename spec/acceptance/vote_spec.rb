require File.dirname(__FILE__) + '/acceptance_helper'

feature "Vote", %q{
  In order to express my opinion
  As an user
  I want to vote positively or negatively on a proposal
} do

  let(:proposal) { Factory(:proposal) }
  let(:event) { proposal.event }


  scenario "While not logged in, I should not be able to like a proposal" do
    visit event_page(event)

    click_like

    page.should have_content("Sign in")
  end

  scenario "While not logged in, I should not be able to dislike a proposal" do
    visit event_page(event)

    click_dislike
    page.should have_content("Sign in")
  end

  scenario "While logged in, I should be able to like a proposal" do
    sign_in

    visit event_page(event)

    click_like
    page.should have_no_content("Sign in")
  end

  scenario "While logged in, I should be able to dislike a proposal" do
    sign_in

    visit event_page(event)

    click_dislike
    page.should have_no_content("Sign in")
  end

  scenario "While I've already voted, I should be notified that I can't vote again" do
    sign_in

    visit event_page(event)

    click_like
    page.should have_content("You've already voted")
  end

  def click_like
    find("a[href*='/like']").click
  end

  def click_dislike
    find("a[href*=dislike]").click
  end
end