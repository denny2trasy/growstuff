require 'spec_helper'

describe 'member' do

  context 'valid member' do
    before(:each) do
      @member = FactoryGirl.build(:member)
    end

    it 'should save a basic member' do
      @member.save.should be_true
    end

    it 'should be fetchable from the database' do
      @member.save
      @member2 = Member.find(@member.id)
      @member2.should be_an_instance_of Member
      @member2.login_name.should == "member1"
      @member2.encrypted_password.should_not be_nil
    end

    it 'should have a friendly slug' do
      @member.save
      @member.slug.should     == "member1"
    end

    it 'should have a default garden' do
      @member.save
      @member.gardens.count.should == 1
    end

    it 'should stringify as the login_name' do
      @member.to_s.should == 'member1'
      "#{@member}".should == 'member1'
    end

    it 'should be able to fetch posts' do
      @post = FactoryGirl.create(:post, :author => @member)
      @member.posts.should eq [@post]
    end

    it 'should be able to fetch gardens' do
      @member.save
      @member.gardens.first.name.should eq "Garden"
    end

  end

  context 'no TOS agreement' do
    before(:each) do
      @member = FactoryGirl.build(:no_tos_member)
    end

    it "should refuse to save a member who hasn't agreed to the TOS" do
      @member.save.should_not be_true
    end
  end

end
