require 'spec_helper'

describe DataMapper::ChunkedQuery do
  subject { TestModel }

  it "should allow chunked queries directly from Models" do
    subject.chunks(1).length.should == 100
  end

  it "should allow chunked queries from other queries" do
    subject.all(:number.lte => 50).chunks(1).length.should == 50
  end

  it "should allow iterating over every resource" do
    count = 0

    subject.each_chunk(2) { |chunk| count += chunk.length }

    count.should == 100
  end

  it "should allow processing records in batch" do
    count = 0

    subject.batch(2) { |resource| count += 1 }

    count.should == 100
  end
end
