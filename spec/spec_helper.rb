$:.unshift('lib') unless $:.first == 'lib'

require 'ontopia/topicmaps'

RSpec.configure { |config|
  config.include(Module.new {
    def data(file)
      File.join(File.dirname(__FILE__), 'data', file)
    end

    def otm(file)
      Ontopia::Topicmaps::Topicmap.new(data(file))
    end
  })
}
