require "spec_helper"

class TestClassWithKnownKeys
  extend  Zuck::FbObject::Helpers
  def self.known_keys
    []
  end
end

describe Zuck::FbObject::Helpers do

  let(:graph_mock){ mock("graph") }
  let(:class_without_known_keys){ Class.new { extend  Zuck::FbObject::Helpers } }

  describe "#get" do
    it "forwards to koala" do
      graph_mock.should_receive(:get_object).with("/foo", fields: "").and_return(true)
      TestClassWithKnownKeys.send(:get, graph_mock, "/foo")
    end

    it "does not swallow exceptions" do
      graph_mock.should_receive(:get_object).with("/foo", fields: "").and_raise("broken")
      expect{
        TestClassWithKnownKeys.send(:get, graph_mock, "/foo")
      }.to raise_error(Zuck::Error::GetRequestFailed)
    end
  end

  describe "#create_connection" do
    it "forwards to koala" do
      graph_mock.should_receive(:put_connections).with(:parent, :connection, :args, :opts).and_return(true)
      class_without_known_keys.send(:create_connection, graph_mock, :parent, :connection, :args, :opts)
    end

    it "does not swallow exceptions" do
      graph_mock.should_receive(:put_connections).with(:parent, :connection, :args, :opts).and_raise("broken")
      expect{
        class_without_known_keys.send(:create_connection, graph_mock, :parent, :connection, :args, :opts)
      }.to raise_error(Zuck::Error::CreateConnectionsFailed)
    end
  end

  describe "#post" do
    it "forwards to koala" do
      graph_mock.should_receive(:graph_call).with("path", :data, "post", :opts).and_return(true)
      class_without_known_keys.send(:post, graph_mock, :path, :data, :opts)
    end

    it "does not swallow exceptions" do
      graph_mock.should_receive(:graph_call).with("path", :data, "post", :opts).and_raise("broken")
      expect{
        class_without_known_keys.send(:post, graph_mock, :path, :data, :opts)
      }.to raise_error(Zuck::Error::PostRequestFailed)
    end
  end

  describe "#delete" do
    it "forwards to koala" do
      graph_mock.should_receive(:delete_object).with(:id).and_return(true)
      class_without_known_keys.send(:delete, graph_mock, :id)
    end

    it "does not swallow exceptions" do
      graph_mock.should_receive(:delete_object).with(:id).and_raise("broken")
      expect{
        class_without_known_keys.send(:delete, graph_mock, :id)
      }.to raise_error(Zuck::Error::DeleteRequestFailed)
    end
  end
end
