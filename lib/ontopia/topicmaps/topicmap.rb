#--
###############################################################################
#                                                                             #
# ontopia-topicmaps -- Query topic maps with Ontopia.                         #
#                                                                             #
# Copyright (C) 2013-2015 Jens Wille                                          #
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

module Ontopia

  module Topicmaps

    class Topicmap

      Topicmaps.init(self)

      TOPICMAP_READER = {
        '.ctm'  => :CTMTopicMapReader,
        '.jtm'  => :JTMTopicMapReader,
        '.ltm'  => :LTMTopicMapReader,
        '.rdf'  => :RDFTopicMapReader,
        '.xfml' => :XFMLTopicMapReader,
        '.xtm'  => :XTMTopicMapReader
      }

      QUERY = {
        all_topics: <<-EOT,
select $TOPIC from
  topic($TOPIC),
  item-identifier($TOPIC, $_)?
        EOT
        count_all_topics: <<-EOT
select count($TOPIC) from
  topic($TOPIC),
  item-identifier($TOPIC, $_)?
        EOT
      }

      QUERY_PROJECTION_RE = %r{\bselect\s+(.+)\s+from\b}i

      class << self

        def extract_query_projection(query)
          projection = query[QUERY_PROJECTION_RE, 1]
          projection.delete('$,').split if projection
        end

      end

      def initialize(file)
        Topicmaps.setup_classpath

        @file = file.include?(File::SEPARATOR) ? file :
          File.join(Topicmaps.base, 'topicmaps', file)

        @tm = read(@file)
      end

      attr_reader :tm, :file

      def count(query = nil, declarations = nil)
        query ||= :count_all_topics
        query_for_list(query, declarations) { |i,| i }.first || 0
      end

      def query(query = nil, declarations = nil, str = nil)
        str = Topicmaps.stringifier(str || :default)

        query_for_list(query, declarations, &block_given? ?
          lambda { |i, *| yield(i, str) } : lambda { |i, *| str[i] }).to_a
      end

      def query_maps(query = nil, declarations = nil)
        query_wrapper(declarations).query_for_maps(query_string(query)).to_a
      end

      def topics(value_str = nil, key_str = nil)
        hash, key_str = {}, Topicmaps.stringifier(key_str || :id)

        query(:all_topics, nil, value_str) { |i, str|
          hash[key_str[i]] = str[i]
        }

        hash
      end

      def extract_query_projection(query)
        self.class.extract_query_projection(query)
      end

      def extract_query_variables(query)
        query_wrapper.get_query_processor.parse(query).get_selected_variables.to_a
      end

      private

      def read(file, reader = nil)
        reader ||= TOPICMAP_READER[ext = File.extname(file)]
        raise "Unsupported file format: #{ext}" unless reader

        self.class.const_get(reader).new(Java::JavaIo::File.new(file)).read
      rescue Java::JavaIo::IOException => err
        raise "Error reading topic map: #{err}"
      end

      def query_string(query)
        QUERY.key?(query ||= :all_topics) ? QUERY[query] :
          query.is_a?(Symbol) ? raise("No such query: #{query}") : query
      end

      def query_wrapper(declarations = nil)
        qw = QueryWrapper.new(tm)
        qw.set_declarations(declarations) if declarations
        qw
      end

      def query_for_list(query, declarations = nil, &block)
        args = [query_string(query)]
        args << RowMapper.new(&block) if block

        query_wrapper(declarations).query_for_list(*args)
      rescue OntopiaRuntimeException => err
        raise "Query error: #{err}"
      end

      class RowMapper

        Topicmaps.init(self, :RowMapperIF)

        def initialize(&block)
          @block = block
        end

        def map_row(result, rowno)
          @block[result.get_value(0), rowno]
        end

      end

    end

  end

end
