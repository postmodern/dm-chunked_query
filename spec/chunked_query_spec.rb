require 'spec_helper'
require 'dm/chunked_query'

describe DataMapper::ChunkedQuery do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
