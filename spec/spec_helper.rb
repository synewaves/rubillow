require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require File.expand_path("../../lib/rubillow", __FILE__)
require 'rspec'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each do |file|
  require file
end

def get_xml(file)
  File.open(File.expand_path("../xml/" + file, __FILE__)).read
end