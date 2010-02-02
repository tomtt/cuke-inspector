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
          @@pickle_parser ||= Pickle::Parser.new(:config => Pickle::Config.new)
          @@pickle_capture_methods.each do |capture_method|
            regexp_string.gsub!(@@pickle_parser.send(capture_method), "\#{#{capture_method}}")
          end
        end
        regexp_string
      end

      private

      def self.reset
        @@pickle_parser = nil
      end
    end
  end
end
