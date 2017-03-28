require 'spec_helper'

RSpec.describe TelevisionShow do
  describe "initialize" do

    it 'has a title' do
      show = TelevisionShow.new("Friends", "NBC", "1994", "Friends in NYC", "Comedy")
      expect(show.title).to eq("Friends")
    end

    it 'has a network' do
      show = TelevisionShow.new("Friends", "NBC", "1994", "Friends in NYC", "Comedy")
      expect(show.network).to eq("NBC")
    end
  end

  describe "self.all" do

    it "should return an array" do
      show = TelevisionShow.all

      expect(show).to eq([])
    end
  end
end
