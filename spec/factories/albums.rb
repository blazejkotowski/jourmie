FactoryGirl.define do
	factory :album do
		start_date 'Mon, 27 May 2013'
		end_date 'Tue, 28 May 2013'
		name 'My Album'
		user_id '1'
		participations '1'
		participations_count '1'
		places_count '0'	
	end
	
	factory :participations do
		album_id '1'
		user_id '1'
	end
	
	factory :user do
		email 'test@example.com'
		password '12345'
		password_confirmation '12345'
		albums_count '1'
	end
end
