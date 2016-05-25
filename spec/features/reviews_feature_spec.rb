require 'rails_helper'

feature 'Reviewing:' do
	before { 
		Restaurant.create(name: 'KFC') 
		User.create(email: 'foo@bar.com', password: '00000000', password_confirmation: '00000000')
	}

	scenario 'allow users to leave review using a form' do
		visit '/'
		click_link 'Sign in'
		fill_in 'Email', with: 'foo@bar.com'
		fill_in 'Password', with: '00000000'
		click_button 'Log in'
		
		click_link 'Review KFC'
		fill_in 'Thoughts', with: "so so"
		select '3', from: 'Rating'
		click_button 'Leave Review'
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content("so so")
	end

end

