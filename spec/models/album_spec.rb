require 'spec_helper'
describe Album do

	describe "Relations" do
		it { should belong_to(:user) }
		it { should have_many(:participants).through(:participations)}
		it { should have_many(:places)}
		it { should have_many(:roads)}
	end
		
	describe "Attributes" do
		it { should validate_presence_of(:name) }
		it { should validate_numericality_of(:user_id) }
		it { should validate_presence_of(:user_id) }
		it { should validate_numericality_of(:participations_count) }
		it { should validate_presence_of(:participations_count) }
		it { should validate_numericality_of(:places_count) }
		it { should validate_presence_of(:places_count) }
		it { should validate_numericality_of(:jourmie_cover_image) }
		it { should validate_presence_of(:jourmie_cover_image) }
		it { should validate_presence_of(:slug) }
	end
	
	describe "Rules" do
		
		before(:each) do
			@user = User.create(:email => 'test@test.com', :password => '12345678', :password_confirmation => '12345678')
			@attr = {
				:name =>'My Album'
				}	
		end		
		
		it "should have allways a owner" do
			Album.create(@attr.merge(:user_id => '')).should_not be_valid
		end

		it "should remove album on user removal" do
			album =@user.albums.create!(@attr)
			@user.delete.should change(Album, :count)
		end

		it "should remove all participations on album delete" do
			album = Album.create!(@attr.merge(:user_id => '1', :places_count => '1'))
			Participation.create!(:album_id => '1', :user_id => '1')
			Album.delete(album.id).should change(Participation, :count )
		end

		it "should not allow to have negative participations" do
			Album.create(@attr.merge(:participations_count => '-1',:user_id => '1')).should_not be_valid
		end

		it "should not allow to have negative places" do
			Album.create(@attr.merge(:places_count => '-1',:user_id => '1')).should_not be_valid
		end

		it "should not allow creating an album without places" do
			Album.create(@attr.merge(:places_count => '0',:user_id => '1')).should_not be_valid
		end 

		it "should not allow end date to be earlier than start date on creation" do
			expect {Album.create!(@attr.merge(:user_id =>'1',:start_date => Date.today, :end_date => Date.yesterday), :places_count => '1')}.to raise_error
		end

		it "should not allow end date to be earlier than start date on update" do
			album = Album.create!(@attr.merge(:user_id =>'1',:start_date => Date.today, :places_count => '1'))
			expect {album.update(:end_date, Date.yesterday)}.to raise_error
		end	

		it "should create an instance of album given valid attributes" do
			@user.albums.create!(@attr.merge(:places_count => '1')).should be_valid				
		end
		
		it "should return the correct name of the album" do
			album = Album.create(@attr)
			album.name.should == "My Album"
		end

		it "should return the correct url of the album cover image, when no custom image is set" do
			album = Album.create(@attr)
			album.cover_image.should == "/assets/covers/cover"+album.jourmie_cover_image.to_s+".jpg"
		end		

		it "should return the correct slug for the album" do
			album = Album.create(@attr)
			album.slug.should == "my-album"
		end	
	
	end
	
end
