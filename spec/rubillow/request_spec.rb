require "spec_helper"

describe Rubillow::Request, ".get" do
  let(:request)  { stub("Request",  :get  => response) }
  let(:response) { stub("Response", :body => '<?xml version="1.0" encoding="utf-8"?>', :code => 200) }
  let(:zwsid)    { "xyz123-oo" }

  before do
    Rubillow::Request.stubs(:uri).returns("/")
    Rubillow::Request.stubs(:request).returns(request)
  end

  it "constructs the request URI" do
    Rubillow::Request.get("/", :option => 1)
    Rubillow::Request.should have_received(:uri).with("/", :option => 1)
  end

  it "includes access key when configured" do
    Rubillow.configuration.zwsid = zwsid
    Rubillow::Request.get("/")
    Rubillow::Request.should have_received(:uri).with("/", :zws_id => zwsid)
  end

  it "allows overriding of configured access key" do
    Rubillow.configuration.zwsid = zwsid
    Rubillow::Request.get("/", :zws_id => "abc890_11")
    Rubillow::Request.should have_received(:uri).with("/", :zws_id => "abc890_11")
  end

  it "makes an API request" do
    Rubillow::Request.get("/")
    request.should have_received(:get).with("/")
  end

  it "returns the XML for a successful response" do
    Rubillow::Request.get("/").should == '<?xml version="1.0" encoding="utf-8"?>'
  end

  it "returns false for any response code other than 200" do
    response.stubs(:code => "401")
    Rubillow::Request.get("/").should == false
  end
end

describe Rubillow::Request, ".request" do
  it "creates a new HTTP client" do
    Rubillow::Request.request.should be_a(Net::HTTP)
  end

  it "connects to configured host and port" do
    Rubillow::Request.request.address.should == Rubillow.configuration.host
    Rubillow::Request.request.port.should    == Rubillow.configuration.port
  end

  it "sets configured open and read timeouts" do
    Rubillow::Request.request.open_timeout.should == Rubillow.configuration.http_open_timeout
    Rubillow::Request.request.read_timeout.should == Rubillow.configuration.http_read_timeout
  end
end

describe Rubillow::Request, ".uri" do
  it "generates a request path and query string based on parameters" do
    Rubillow::Request.uri("GetRegionChart", { :key_with_spaces => 12, :normal => "maybe", :camelCased => 1340}).should == "/webservice/GetRegionChart.htm?camelCased=1340&key-with-spaces=12&normal=maybe"
  end
end