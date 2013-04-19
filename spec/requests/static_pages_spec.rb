require 'spec_helper'

describe "StaticPages" do
	
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	subject { page }

	describe "Home Page" do 

		before { visit root_path  } 	

		it { should have_selector('h1', :text => 'Welcome to the Sample App') }

		it { should have_selector('title', :text => "#{base_title} | Home") }
	end

	describe "Help Page" do 

		before { visit help_path } 	

		it { should have_selector('h1', :text => 'Help') }

		it { should have_selector('title', :text => "#{base_title} | Help") }
	end

	describe "About Page" do 

		before { visit about_path } 	

		it { should have_selector('h1', :text => 'About us') }

		it { should have_selector('title', :text => "#{base_title} | About") }
	end

	describe "Contact page" do 

		before { visit contact_path } 	

		it { should have_selector('h1', :text => 'Contact') }

		it { should have_selector('title', :text => "#{base_title} | Contact") }
	end
end