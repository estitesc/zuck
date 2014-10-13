require "spec_helper"

describe Zuck::KoalaMethods, "#graph" do
  context "instantiated with improper class" do
    it "raises a incorrect class error message" do
      expect{
        Zuck.graph = Struct.new(:params)
      }.to raise_error(Zuck::Error::InvalidClass)
    end
  end

  context "instantiated without an access token" do
    it "raises a missing token error message" do
      expect{
        Zuck.graph = Koala::Facebook::API.new('')
      }.to raise_error(Zuck::Error::MissingToken)
    end
  end

  context "with proper class and access token" do
    it "instantiates a new instance of a graph" do
      expect{
        Zuck.graph = Koala::Facebook::API.new('test_token')
      }.not_to raise_error
    end
  end
end
