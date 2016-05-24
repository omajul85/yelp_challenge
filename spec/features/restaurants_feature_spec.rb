require 'rails_helper'

feature 'Restaurants:' do
  context 'No restaurants have been added:' do
    scenario 'Should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
	  before { Restaurant.create(name: 'KFC') }

  	scenario 'display restaurants' do
	    visit '/restaurants'
	    expect(page).to have_content('KFC')
	    expect(page).not_to have_content('No restaurants yet')
	  end
	end

	# (C)RUD
	context 'Creating restaurants' do
		scenario 'prompts user to fill out a form, then displays the new restaurant' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			fill_in 'Description', with: 'Deep fried goodness'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		context 'Creating an invalid restaurant' do
	    it 'does not let you submit a name that is too short' do
	      visit '/restaurants'
	      click_link 'Add a restaurant'
	      fill_in 'Name', with: 'Le'
	      click_button 'Create Restaurant'
	      expect(page).not_to have_content 'Le'
	      expect(page).to have_content 'error'
	    end
	  end

	end

	# C(R)UD
	context 'viewing restaurants' do
		let!(:kfc){ Restaurant.create(name:'KFC', description: 'Deep fried goodness') }

		scenario 'lets a user view a restaurant' do
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(page).to have_content 'Deep fried goodness'
			expect(current_path).to eq "/restaurants/#{kfc.id}"
		end
	end

	# CR(U)D
	context 'editing restaurants' do
		before { Restaurant.create(name: 'KFC', description: 'Pollo grasiento') }

		scenario 'let a user edit a restaurant' do
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'KFC'
			fill_in 'Description', with: 'Pollo grasiento'
			click_button 'Update Restaurant'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(page).to have_content 'Pollo grasiento'
		end
	end

	# CRU(D)
	context 'deleting restaurants' do
		before { Restaurant.create(name: 'KFC') }

		scenario 'let a user delete a restaurant' do
			visit '/restaurants'
			click_link 'Delete'
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content 'Restaurant deleted succesfully'
		end
	end

end