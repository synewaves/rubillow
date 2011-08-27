require "spec_helper"

describe Rubillow::Configuration do
  it { should have_configuration_option(:host).default("www.zillow.com") }
  it { should have_configuration_option(:port).default(80) }
  it { should have_configuration_option(:path).default("webservice/") }
  it { should have_configuration_option(:zwsid).default(nil) }
  it { should have_configuration_option(:http_open_timeout).default(2) }
  it { should have_configuration_option(:http_read_timeout).default(2) }
end