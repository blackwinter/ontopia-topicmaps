#--
###############################################################################
#                                                                             #
# ontopia-topicmaps -- Query topic maps with Ontopia.                         #
#                                                                             #
# Copyright (C) 2013-2014 Jens Wille                                          #
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

    module Version

      MAJOR = 0
      MINOR = 0
      TINY  = 3

      class << self

        # Returns array representation.
        def to_a
          [MAJOR, MINOR, TINY]
        end

        # Short-cut for version string.
        def to_s
          to_a.join('.')
        end

      end

    end

    VERSION = Version.to_s

  end

end
