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

module Ontopia
  module Topicmaps

    class IdStringifier

      NO_VALUE = '[No ID]'.freeze

      Topicmaps.register_stringifier(self, :id) {
        URIFragmentLocator.field_accessor :fragment
      }

      def to_string(object)
        case object
          when TopicIF            then to_string(object.get_item_identifiers.first)
          when TypedIF            then to_string(object.get_type)
          when URIFragmentLocator then object.fragment
          else                         NO_VALUE
        end
      end

    end

    class AnyNameStringifier

      NO_VALUE = '[No Name]'.freeze

      Topicmaps.register_stringifier(self, :name)

      def initialize
        @topic_str = Topicmaps.topic_stringifier
      end

      def to_string(object)
        case object
          when TopicIF then @topic_str[object]
          when TypedIF then to_string(object.get_type)
          else              NO_VALUE
        end
      end

    end

  end
end
