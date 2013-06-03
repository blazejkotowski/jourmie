require 'spec_helper'

describe Place do
	describe "Relations" do
		it { should belong_to :album }
		it { should have_one :road_to }
		it { should have_one :road_from }
		it { should have_many :photos }
		it { should have_many :videos }
		it { should have_many :musics }
		it { should validate_presence_of(:latitude)}
		it { should validate_presence_of(:longitude)}
		it { should validate_presence_of(:name)}

	end

	describe "Rules" do
		before(:each) do
			@attr = {
				:name => "Place1",
				:latitude => "1.0",
				:longitude => "1.0",
			}
		end

		it "should not allow different places with same location" do
			Place.create!(@attr)
			Place.new(@attr.merge(:name => "Place2")).should_not be_valid
		end

		it "should not allow start and end places to be the same" do
			Place.new(@attr.merge(:road_from_id => "1", :road_to_id => "1")).should_not be_valid
		end

		it "should not allow end date to be earlier than start date on creation" do
			expect {Place.create!(@attr.merge(:date_from => Date.today, :date_to => Date.yesterday,))}.to raise_error
		end

		it "should not allow end date to be earlier than start date on update" do
			place = Place.create!(@attr.merge(:date_from => Date.today))
			expect {place.update(:date_to, Date.yesterday)}.to raise_error
		end	

		it "should remove roads with place_from on place delete" do
			place = Place.create!(@attr)
			place.delete
			Road.find_all_by_place_from_id(place.id).count.should == 0
		end

		it "should remove roads with place_to on place delete" do
			place = Place.create!(@attr)
			place.delete
			Road.find_all_by_place_to_id(place.id).count.should == 0
		end

		it "should remove place on album delete" do
			album = Album.create!(:name => "my album",:user_id => "1")
			album.places.create(@attr)
			expect { Album.first.delete }.to change(Place,:count)
		end
	end

end