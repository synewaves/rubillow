require "spec_helper"

describe Rubillow do
  it "allows setting configuration as a block" do
    Rubillow.configure do |config|
      config.http_open_timeout = 10
      config.http_read_timeout = 30
    end
    
    Rubillow.configuration.http_open_timeout.should == 10
    Rubillow.configuration.http_read_timeout.should == 30
  end
end