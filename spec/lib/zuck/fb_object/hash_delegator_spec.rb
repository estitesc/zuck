require 'spec_helper'

class TestClassWithoutKnownKeys
  include Zuck::HashDelegator
end

class TestClassWithKnownKeys
  include Zuck::HashDelegator
  known_keys :bar
end

describe Zuck::HashDelegator do

  let(:class_without_known_keys){ TestClassWithoutKnownKeys.new }
  let(:class_with_known_keys){ TestClassWithKnownKeys.new }

  context "#known_keys" do
    context '#get' do
      it "if known keys are empty" do
        TestClassWithoutKnownKeys.known_keys.should eq []
      end

      it "if known keys are present" do
        class_with_known_keys.known_keys.should eq [:bar]
      end
    end

    context '#set' do
      it "via symbol" do
        class_with_known_keys[:bar] = :foo
        class_with_known_keys.bar.should == :foo
      end

      it "via method " do
        class_with_known_keys.bar = :foo
        class_with_known_keys.bar.should == :foo
      end
    end
  end

  context "#set_data" do
    it "allows to assign a hash" do
      class_without_known_keys.set_data('some' => "thing", bar: 1)
      class_without_known_keys[:some].should == "thing"
    end
  end

  context '#data' do
    it "allows to assign a hash using a shortcut" do
      class_without_known_keys.data = {'some' => "thing", bar: 1}
      class_without_known_keys[:some].should == "thing"
    end

    it "has a shortcut getter" do
      class_without_known_keys[:foo] = :bar
      class_without_known_keys.data.should == {foo: :bar}
    end
  end

  context '#[]' do
    it "assigns a value" do
      class_without_known_keys[:foo] = :bar
      class_without_known_keys[:foo].should == :bar
    end

    it "transforms keys to symbols" do
      class_without_known_keys['bar'] = :foo
      class_without_known_keys['bar'].should == :foo
      class_without_known_keys[:bar].should == :foo
    end
  end

  context '#to_s' do
    it "becomes a pretty string" do
      class_without_known_keys[:some] = "thing"
      class_without_known_keys[:bar]  = 1
      class_without_known_keys.to_s.should == '#<TestClassWithoutKnownKeys some: "thing", bar: 1>'
    end
  end
end
