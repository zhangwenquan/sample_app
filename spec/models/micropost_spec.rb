require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before do 
	#This code is wrong!
	@micropost = user.microposts.build(content: "Lorem ipsum")
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
	

  it { should be_valid }

  describe 'when user_id is not present' do 
	before { @micropost.user_id = nil }
	it should_not { be_valid }
  end

  describe 'accessible attributes' do 
	it 'should not allow access to user_id' do 
		expect do 
			Micropost.new(user_id: user.id)
		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
	end
  end

  describe 'micropost association' do 
	before { @user.save }
	let!(:older_micropost) do 
		FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
	end
	let!(:newer_micropost) do 
		FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
	end

	it 'should have the right microposts have the right order' do 
		@user.microposts.should == [newer_micropost, older_micropost]
	end
	it 'should destroy associated microposts' do 
		microposts = @user.microposts.dup
		@user.destroy
		microposts.should_not be_empty
		microposts.each do |m|
			Micropost.find_by_id(micropost.id).should be_nil
		end
	end
  end

  describe 'with blank content' do 
	before { @micropost.content = '' }
	it { should_not be_valid }
  end

  describe 'with content that is too long' do 
	before { @micropost.content = 'a'*141 }
	it { should_not be_valid }
  end
		
end
