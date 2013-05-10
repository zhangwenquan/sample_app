require 'spec_helper'
include ApplicationHelper

describe "StaticPages" do
	
	subject { page }

	shared_examples_for "all static pages" do 
		it { should have_selector('h1', :text => heading) }
		it { should have_selector('title', :text => full_title(page_title)) }
	end

	describe "Home Page" do 

		before { visit root_path  } 
		let(:heading) { 'Welcome to the Sample App' }
		let(:page_title) { 'Home' }
		
		it_should_behave_like "all static pages"
	end

	describe "Help Page" do 

		before { visit help_path } 	
		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }
		
		it_should_behave_like "all static pages"
	end

	describe "About Page" do 

		before { visit about_path } 	
		let(:heading) { 'About us' }
		let(:page_title) { 'About' }
		
		it_should_behave_like "all static pages"
	end

	describe "Contact page" do 

		before { visit contact_path } 	
		let(:heading) { 'Contact' }
		let(:page_title) { 'Contact' }
		
		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do 
		visit root_path
		click_link 'About'
		page.should have_selector('title', :text => full_title('About'))
		click_link 'Help'
		page.should have_selector('title', :text => full_title('Help'))
		click_link 'Contact'
		page.should have_selector('title', :text => full_title('Contact'))
		click_link 'Home'
		page.should have_selector('title', :text => full_title('Home'))
		click_link 'Sign up now!'
		page.should have_selector('title', :text => full_title('Sign up'))
	end

	describe 'for signed_in users' do 
		let(:user) { FactoryGirl.create(:user) }
		before do 
			FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
			FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
			sign_in user
			visit root_path
		end

		it "should render the user's feed" do 
			user.feed.each do |item|
				page.should have_selector("li##{item.id}", item.content)
			end
		end
	end
end