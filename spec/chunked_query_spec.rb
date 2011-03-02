require 'spec_helper'

describe DataMapper::ChunkedQuery do
  it "should allow chunked queries directly from Models" do
    TestModel.chunks(1).length.should == 100
  end

  it "should allow chunked queries from other queries" do
    TestModel.all(:number.lte => 50).chunks(1).length.should == 50
  end
end
