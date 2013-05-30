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
				:longitude => "1.0"
			}
		end

		

		it "should not allow end date to be earlier than start date on creation" do
			expect {Place.create!(@attr.merge(:date_from => Date.today, :date_to => Date.yesterday,))}.to raise_error
		end

		it "should not allow end date to be earlier than start date on update" do
			place = Place.create!(@attr.merge(:date_from => Date.today))
			expect {place.update(:date_to, Date.yesterday)}.to raise_error
		end	
	end

end