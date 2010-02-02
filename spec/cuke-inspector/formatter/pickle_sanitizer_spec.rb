require File.dirname(__FILE__) + '/../../spec_helper'
require 'cuke-inspector/formatter/pickle_sanitizer'
require 'pickle' # pickle is required to run the test suite

module Cucumber
  module Formatter
    describe PickleSanitizer do
      describe "when pickle is not loaded" do
        before do
          Gem.stub!(:available?).with('pickle').and_return false
        end

        it "returns any regexp string unmodified" do
          regexp_string = "a user exists with name: \"??\""
          PickleSanitizer.unpickle(regexp_string).should == regexp_string
        end

        it "never creates a pickle parser" do
          Pickle::Parser.should_not_receive(:new)
          PickleSanitizer.unpickle('foo')
        end
      end

      describe "when pickle is loaded" do
        before do
          PickleSanitizer.reset
          Gem.stub!(:available?).with('pickle').and_return true
          @parser = mock('pickle parser')
          @parser.stub!(:capture_model).and_return 'mock capture model'
          @parser.stub!(:capture_fields).and_return 'mock capture fields'
          @parser.stub!(:capture_factory).and_return 'mock capture factory'
          @parser.stub!(:capture_plural_factory).and_return 'mock capture plural factory'
          @parser.stub!(:capture_predicate).and_return 'mock capture predicate'
          Pickle::Parser.stub!(:new).and_return @parser
        end

        it "creates a pickle parser with a new config" do
          mock_config = mock('pickle config')
          Pickle::Config.stub!(:new).and_return mock_config
          Pickle::Parser.should_receive(:new).with hash_including(:config => mock_config)
          PickleSanitizer.unpickle('foo')
        end

        it "only creates a pickle parser once" do
          PickleSanitizer.unpickle('foo')
          Pickle::Parser.should_not_receive(:new)
          PickleSanitizer.unpickle('foo')
        end

        it "maps a model capture to a placeholder" do
          @parser.stub!(:capture_model).and_return('stubbed model capture regexp')
          regexp_string = "this is a stubbed model capture regexp example"
          PickleSanitizer.unpickle(regexp_string).should ==
            "this is a \#{capture_model} example"
        end

        it "maps a fields capture to a placeholder" do
          @parser.stub!(:capture_fields).and_return('stubbed fields capture regexp')
          regexp_string = "this is a stubbed fields capture regexp example"
          PickleSanitizer.unpickle(regexp_string).should ==
            "this is a \#{capture_fields} example"
        end

        it "maps capture_factory to a placeholder" do
          @parser.stub!(:capture_factory).and_return('stubbed factory capture regexp')
          regexp_string = "this is a stubbed factory capture regexp example"
          PickleSanitizer.unpickle(regexp_string).should ==
            "this is a \#{capture_factory} example"
        end

        it "maps capture_plural_factory to a place holder" do
          @parser.stub!(:capture_plural_factory).and_return('stubbed plural factory capture regexp')
          regexp_string = "this is a stubbed plural factory capture regexp example"
          PickleSanitizer.unpickle(regexp_string).should ==
            "this is a \#{capture_plural_factory} example"
        end

        it "maps capture_predicate" do
          @parser.stub!(:capture_predicate).and_return('stubbed predicate capture regexp')
          regexp_string = "this is a stubbed predicate capture regexp example"
          PickleSanitizer.unpickle(regexp_string).should ==
            "this is a \#{capture_predicate} example"
        end

        it "maps capture_predicate even if it has changed" do
          predicate_example = "((?:position[_ ]by[_ ]type|respond[_ ]to[_ ]without[_ ]attributes|invalid|publishing[_ ]enabled|attribute[_ ]present|nil|updated[_ ]at|acts[_ ]like|first[_ ]item|present))"          
          @parser.stub!(:capture_predicate).and_return(predicate_example)
          regexp_string = "this string contains a simple predicate capture ((?:position[_ ]by[_ ]type|respond[_ ]to[_ ]without[_ ]attributes|invalid|publishing[_ ]enabled)) just before here"
          PickleSanitizer.unpickle(regexp_string).should ==
            'this string contains a simple predicate capture #{capture_predicate} just before here'
        end
      end
    end
  end
end
