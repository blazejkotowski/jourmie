require 'spec_helper'

describe Friendship do
	describe "Relations" do
		it { should belong_to :user}
		
	end
end