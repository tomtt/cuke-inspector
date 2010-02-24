module Cucumber
  module Formatter
    class PickleSanitizer
      @@pickle_parser = nil
      @@pickle_capture_methods = ['capture_model',
                                  'capture_fields',
                                  'capture_factory',
                                  'capture_plural_factory',
                                  'capture_predicate']

      def self.unpickle(regexp_string)
        if Gem.available?('pickle')
          require 'pickle'
          @@pickle_parser ||= Pickle::Parser.new(:config => Pickle::Config.new)
          @@pickle_capture_methods.each do |capture_method|
            regexp_string.gsub!(@@pickle_parser.send(capture_method), "\#{#{capture_method}}")
          end
          regexp_string = hacky_capture_predicate_sanitizer(regexp_string)
        end

        regexp_string
      end

      # Because the capture_predicate method at the time of running
      # this code seems to differ from when it was run in the step
      # that defined it, the simple method of replacing it does not
      # work. Here is a convoluted regexp that does it. Better
      # suggestions are welcome.
      def self.hacky_capture_predicate_sanitizer(regexp_string)
        regexp_string.gsub(/\(\(\?:((?:\w+(?:\[_ \]\w+)*)(?:\|\w+(?:\[_ \]\w+)*)*)\)\)/, '#{capture_predicate}')
      end

      def self.find_methods_that_match(regexp_string)
        methods = @@pickle_parser.methods.select { |m| m =~ /^match|capture/ }
        methods.select do |method|
          begin
            foo = @@pickle_parser.send(method)
            regexp_string.include?(foo)
          rescue
            false
          end
        end.sort
      end

      private

      def self.reset
        @@pickle_parser = nil
      end
    end
  end
end
