require 'spec_helper'

describe "crops/edit" do
  before(:each) do
    controller.stub(:current_user) { Member.new }
    @crop = assign(:crop, FactoryGirl.create(:maize))
    render
  end

  it "renders the edit crop form" do
    assert_select "form", :action => crops_path(@crop), :method => "post" do
      assert_select "input#crop_system_name", :name => "crop[system_name]"
      assert_select "input#crop_en_wikipedia_url", :name => "crop[en_wikipedia_url]"
    end
  end
end
