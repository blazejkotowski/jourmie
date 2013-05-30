require 'spec_helper'

describe Friendship do
	describe "Relations" do
		it { should belong_to :user}
		it { should belong_to :friend}
	end

	describe "Attributes" do
		it { should validate_presence_of(:user_id) }
		it { should validate_presence_of(:friend_id) }
		it { should validate_presence_of(:state) }
	end

	describe "Rules" do
		before(:each) do
			@attr={:user_id => "1", :friend_id => "2"}
			User.create(:email => "test@test.com",:password => "12345678", :password_confirmation => "12345678")
			User.create(:email => "test2@test.com",:password => "12345678", :password_confirmation => "12345678")
		end

		it "should not allow a user to be friends with itself" do
			Friendship.new(@attr.merge(:friend_id =>"1",:state =>"requested")).should_not be_valid
		end

		it "should create a inverse tuple when request is sent" do
			friendship = Friendship.create!(@attr.merge(:state => "requested"))
			Friendship.find_by_user_id_and_friend_id(friendship.friend_id,friendship.user_id).should_not be_nil
		end

		it "should create a inverse tuple when request is sent with pending state" do
			friendship = Friendship.create!(@attr.merge(:state => "requested"))
			Friendship.find_by_user_id_and_friend_id(friendship.friend_id,friendship.user_id).state.should == "pending"
		end

		it "should change both states when friendship is accepted" do
			friendship = Friendship.create!(@attr.merge(:state => "accepted"))
			Friendship.find_by_user_id_and_friend_id(friendship.friend_id,friendship.user_id).state.should == "accepted"
		end

		it "should remove both friendships when it's rejected" do
			friendship = Friendship.create(!@attr.merge(:state => "requested"))
		end

		it "should only allow state to be requested, pending or accepted" do
			Friendship.new(@attr.merge(:state =>"rejected")).should_not be_valid
		end

		it "should allways remove both friendships when one of them is removed" do
			Friendship.create!(@attr.merge(:state => "accepted"))
			Friendship.first.accept
			expect { Friendship.first.delete }.to change(Friendship,:count).by(2)
		end

		it "should not allow two requested friendship requests" do
			Friendship.create!(@attr.merge(:state => "requested"))
			Friendship.create!(:user_id => "2", :friend_id => "1", :state => "requested").should_not be_valid
		end

		it "should not allow two pending friendship requests" do
			Friendship.create!(@attr.merge(:state => "pending"))
			Friendship.create!(:user_id => "2", :friend_id => "1", :state => "pending").should_not be_valid
		end

		it "should not allow one accepted and one pending friendship" do
			Friendship.create!(@attr.merge(:state => "accepted"))
			Friendship.create!(:user_id => "2", :friend_id => "1", :state => "pending").should_not be_valid
		end

		it "should not allow one accepted and one requested friendship requests" do
			Friendship.create!(@attr.merge(:state => "accepted"))
			Friendship.create!(:user_id => "2", :friend_id => "1", :state => "requested").should_not be_valid
		end
	end
end