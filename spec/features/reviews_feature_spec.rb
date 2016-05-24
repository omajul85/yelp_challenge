require 'rails_helper'

feature 'Reviewing:' do
	before { Restaurant.create(name: 'KFC') }

	scenario 'allow users to leave review using a form' do
		visit '/restaurants'
		click_link 'Review'
		fill_in 'Thoughts', with: "so so"
		select '3', from: 'Rating'
		click_button 'Leave Review'
		
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content("so so")
	end

end

