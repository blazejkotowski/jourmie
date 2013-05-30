require 'spec_helper'

describe UserProfile do

	describe "Relations" do
		it { should belong_to(:user) }
	end

	describe "Attributes" do
		it { should validate_numericality_of(:user_id) }
		it { should ensure_inclusion_of(:sex).in_array(['male','female'])}
		it { should allow_value("12345").for(:phone) }
  		it { should_not allow_value("foo").for(:phone) }
  		it { should allow_value("foo").for(:permalink) }
  		it { should_not allow_value("foo_bar").for(:permalink) }
  		it { should validate_presence_of(:last_name) }
  		it { should validate_presence_of(:first_name) }
  		it { should validate_presence_of(:user_id) }
  		it { should_not allow_value("foo").for(:phone) }
	end

	describe "Rules" do
		before(:each) do
			@user = {:email=> 'test@test.com', :password => "12345678", :password_confirmation => "12345678"}
		end

		it "should be created on User creation" do
			User.create!(@user).should change(UserProfile,:count)	
		end

		it "should be removed on User delete" do
			user = User.create!(@user)
			User.find(user.id).delete.should change(UserProfile, :count)
		end

		it "should have a unique permalink with name" do
			UserProfile.create(:user)
		end
	end
end