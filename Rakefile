require_relative 'lib/ontopia/topicmaps/version'

begin
  require 'hen'

  Hen.lay! {{
    gem: {
      name:         %q{ontopia-topicmaps},
      version:      Ontopia::Topicmaps::VERSION,
      summary:      %q{Query topic maps with Ontopia.},
      author:       %q{Jens Wille},
      email:        %q{jens.wille@gmail.com},
      license:      %q{AGPL-3.0},
      homepage:     :blackwinter,
      platform:     'java',
      requirements: ['Ontopia (http://ontopia.net/)']
    }
  }}
rescue LoadError => err
  warn "Please install the `hen' gem. (#{err})"
end
