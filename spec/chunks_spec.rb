require 'spec_helper'

describe DataMapper::ChunkedQuery::Chunks do
  let(:per_chunk) { 10 }

  subject { TestModel.chunks(per_chunk) }

  it "should count the number of total resources" do
    subject.count.should == TestModel.count
  end

  it "should calculate how many chunks are available" do
    subject.length.should == (TestModel.count / per_chunk)
  end

  it "should round-up when calculate the number of available chunks" do
    TestModel.chunks(TestModel.count * 0.75).length.should == 2
  end

  context "#[]" do
    it "should allow direct access to individual chunks" do
      resources = subject[1]
      numbers = resources.map { |resource| resource.number }

      numbers.should == (11..20).to_a
    end

    it "should allow direct access to a range of chunks" do
      resources = subject[1..2]
      numbers = resources.map { |resource| resource.number }

      numbers.should == (11..30).to_a
    end
  end

  context "#at" do
    let(:expected_numbers) { (11..20).to_a }

    it "should allow accessing chunks at given indices" do
      resources = subject.at(1)
      numbers = resources.map { |resource| resource.number }

      numbers.should == expected_numbers
    end

    it "should allow accessing chunks using non-Integer indices" do
      resources = subject.at('1')
      numbers = resources.map { |resource| resource.number }

      numbers.should == expected_numbers
    end
  end

  it "should allow enumerating through every chunk" do
    resources = []
    subject.each { |chunk| resources += chunk }

    TestModel.all.should == resources
  end
end
