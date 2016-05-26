require 'rails_helper'

feature 'Reviewing:' do
	
	def sign_in(email, password)
	  visit '/'
		click_link 'Sign in'
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		click_button 'Log in'
	end

	def leave_review(thoughts, rating)
	  click_link 'Review KFC'
	  fill_in 'Thoughts', with: thoughts
	  select rating, from: 'Rating'
	  click_button 'Leave Review'
	end

	before { 
		Restaurant.create(name: 'KFC') 
		User.create(email: 'foo@bar.com', password: '00000000', password_confirmation: '00000000')
		User.create(email: 'bar@foo.com', password: '00000000', password_confirmation: '00000000')
	}

	scenario 'allow users to leave review using a form' do
		sign_in('foo@bar.com', '00000000')
		leave_review("so so", '4')
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content("so so")
	end

	scenario 'displays an average rating for all reviews' do
	  sign_in('foo@bar.com', '00000000')
	  leave_review('Mediocre', '3')
	  click_link 'Sign out'
	  sign_in('bar@foo.com', '00000000')
	  leave_review('Great', '5')
	  expect(page).to have_content('Average rating: 4')
	end
end

