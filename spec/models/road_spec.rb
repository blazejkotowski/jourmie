require 'spec_helper'

describe Road do

	describe "Relations" do
		it { should have_many :photos }
		it { should have_many :videos }
		it { should have_many :musics }
		it { should belong_to :album }
		it { should have_one :place_from}
		it { should have_one :place_to }
	
	end

	describe "Attributes" do
		it { should validate_presence_of :place_from_id }
		it { should validate_presence_of :place_to_id }
	end

	describe "Rules" do
		before(:each) do
			Place.create(:name => "Place1",:latitude => "1.0",:longitude => "1.0")
			Place.create(:name => "Place2",:latitude => "1.1",:longitude => "1.0")
			@attr = {
				:place_from_id => "1",
				:place_to_id => "2"	
			}
		end

		it "should not allow both places to be the same" do 
			Road.new(@attr.merge(:place_to_id => "1")).should_not be_valid
		end

		it "should only allow available place_from" do
			Road.new(@attr.merge(:place_from_id => "3")).should_not be_valid
		end

		it "should only allow available place_to" do
			Road.new(@attr.merge(:place_to_id => "3")).should_not be_valid
		end

		it "should remove road on album delete" do
			album = Album.create!(:name => "my album",:user_id => "1")
			album.roads.create(@attr)
			expect { Album.first.delete }.to change(Road,:count)
		end

		it "should only allow mean to be 'train','car','plane','hitchhiking','foot' and 'bike'" do
			Road.new(@attr.merge(:means => "6")).should_not be_valid
		end

	end

end
