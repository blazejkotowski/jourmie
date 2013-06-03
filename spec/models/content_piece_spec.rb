require 'spec_helper'

describe ContentPiece do

	describe "Relations" do
		it { should belong_to(:user) }
		it { should belong_to(:place) }
		it { should belong_to(:road) }
		it { should have_many(:comments)}
		it { should have_many(:likes)}
	end

	describe "Attributes" do
		it { should validate_numericality_of(:user_id) }
		it { should validate_numericality_of(:comments_count) }
		it { should validate_numericality_of(:likes_count) }
		it { should validate_presence_of(:user_id) }
		it { should validate_presence_of(:type) }
		it { should validate_presence_of(:file) }
	end

	describe "Rules" do
		before(:each) do
			@road = Road.create!()
			@attr = {:user_id => '1',:file => 'test', :type => 'music' }		
		end

		it "should only allow Musics, Photos or Videos" do
			expect {ContentPiece.create!(@attr.merge(:type =>'test'))}.to raise_error
		end

		it "should have allways a place or a road associated" do
			expect {ContentPiece.create!(@attr)}.to raise_error
		end

		it "should create an instance of content_piece given valid attributes" do
			ContentPiece.create!(@attr.merge(:place_id => '1')).should be_valid			
		end

		it "should have 0 or more comments for a ContentPiece" do
			ContentPiece.new(@attr.merge(:place_id => '1',:comments_count => "-1)")).should_not be_valid
		end

		it "should have 0 or more likes for a ContentPiece" do
			ContentPiece.new(@attr.merge(:place_id => '1',:likes_count => "-1")).should_not be_valid
		end		
	end

end