require 'rspec'
require 'dm-core/spec/setup'
require 'dm-core/spec/lib/adapter_helpers'

require 'dm-chunked_query'

class TestModel

  include DataMapper::Resource

  property :id, Serial

  property :number, Integer

end

DataMapper::Spec.setup

RSpec.configure do |config|
  config.extend(DataMapper::Spec::Adapters::Helpers)

  config.before(:suite) do
    TestModel.auto_migrate!

    (1..100).each { |i| TestModel.create(:number => i) }
  end
end
