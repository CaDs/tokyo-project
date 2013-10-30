require 'spec_helper'

describe "AreasController" do
  before(:each) do
    @area1 = FactoryGirl.create(:area, name: "area_test1")
    @area2 = FactoryGirl.create(:area, name: "area_test2")
  end

  it "will display the areas with any vision" do
    vision = FactoryGirl.create(:vision, area: @area1)
    get '/areas'
    last_response.body.include?(@area1.name).should be_true
  end

  it "will not display areas with no visions" do
    get '/areas'
    last_response.body.include?(@area2.name).should be_false
  end
end
