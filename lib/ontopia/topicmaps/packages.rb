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

    module Packages

      PACKAGES = {
        'net.ontopia.infoset.impl.basic'    => %w[URIFragmentLocator],
        'net.ontopia.topicmaps.core'        => %w[TopicIF TypedIF],
        'net.ontopia.topicmaps.query.utils' => %w[QueryWrapper RowMapperIF],
        'net.ontopia.topicmaps.utils'       => %w[TopicStringifiers],
        'net.ontopia.topicmaps.utils.ctm'   => %w[CTMTopicMapReader],
        'net.ontopia.topicmaps.utils.jtm'   => %w[JTMTopicMapReader],
        'net.ontopia.topicmaps.utils.ltm'   => %w[LTMTopicMapReader],
        'net.ontopia.topicmaps.utils.rdf'   => %w[RDFTopicMapReader],
        'net.ontopia.topicmaps.utils.xfml'  => %w[XFMLTopicMapReader],
        'net.ontopia.topicmaps.xml'         => %w[XTMTopicMapReader],
        'net.ontopia.utils'                 => %w[OntopiaRuntimeException StringifierIF]
      }

      def self.included(base)
        PACKAGES.each_key { |pkg| base.send(:include_package, pkg) }
      end

    end

  end
end
