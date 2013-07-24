#--
###############################################################################
#                                                                             #
# ontopia-topicmaps -- Query topic maps with Ontopia.                         #
#                                                                             #
# Copyright (C) 2013 Jens Wille                                               #
#                                                                             #
# ontopia-topicmaps is free software: you can redistribute it and/or modify   #
# it under the terms of the GNU Affero General Public License as published    #
# by the Free Software Foundation, either version 3 of the License, or (at    #
# your option) any later version.                                             #
#                                                                             #
# ontopia-topicmaps is distributed in the hope that it will be useful, but    #
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY  #
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public      #
# License for more details.                                                   #
#                                                                             #
# You should have received a copy of the GNU Affero General Public License    #
# along with ontopia-topicmaps. If not, see <http://www.gnu.org/licenses/>.   #
#                                                                             #
###############################################################################
#++

require 'java'

require_relative 'topicmaps/version'
require_relative 'topicmaps/packages'

module Ontopia
  module Topicmaps

    DEFAULT_JARS = ENV['OTM_JARS'] || 'log4j-*:slf4j-log4j*:ontopia-engine-*'
    DEFAULT_BASE = ENV['OTM_BASE'] || '/usr/local/ontopia'

    @init = {}

    @base = nil

    @default_stringifier = nil

    class << self

      attr_reader :base

      def default_stringifier=(str)
        @default_stringifier = stringifier(str)
      end

      def default_stringifier
        @default_stringifier ||= name_stringifier
      end

      def stringifier(str)
        case str
          when self::StringifierIF then str.method(:to_string)
          when Symbol              then send("#{str}_stringifier")
          else                          str
        end
      end

      def count(file, *args)
        Topicmap.new(file).count(*args)
      end

      def query(file, *args, &block)
        Topicmap.new(file).query(*args, &block)
      end

      def query_maps(file, *args)
        Topicmap.new(file).query_maps(*args)
      end

      def topics(file, *args)
        Topicmap.new(file).topics(*args)
      end

      def base=(base)
        setup_classpath(base)
      end

      def setup_classpath(base = nil, jars = nil)
        if @base
          return unless base
          raise "#{self}: $CLASSPATH already set up: #{@base}"
        end

        @base = base ||= DEFAULT_BASE

        Array(jars || DEFAULT_JARS).join(':').split(':').each { |jar|
          (path = Dir[File.join(base, 'lib', "#{jar}.jar")].sort.last) ?
            $CLASSPATH << path : raise("JAR not found: #{jar} (#{base})")
        }

        init.each { |klass, (modules, block)|
          klass.send :include, Packages, *modules.map { |m| const_get(m) }
          klass.class_eval(&block) if block
        }.clear
      end

      protected

      def init(klass = nil, *modules, &block)
        klass ? Topicmaps.init[klass] = [modules, block] : @init
      end

      def define_stringifier(name)
        define_singleton_method(attr = "#{name}_stringifier") {
          singleton_class.send(:attr_reader, attr)
          instance_variable_set("@#{attr}", stringifier(yield))
        }
      end

      def register_stringifier(klass, name)
        init(klass, :StringifierIF) {
          Topicmaps.define_stringifier(name) { new }
          yield if block_given?
        }
      end

    end

    init(self) {
      define_stringifier(:topic) {
        self::TopicStringifiers.get_default_stringifier
      }
    }

  end
end

require_relative 'topicmaps/stringifiers'
require_relative 'topicmaps/topicmap'
