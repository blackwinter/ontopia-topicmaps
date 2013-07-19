require File.expand_path(%q{../lib/ontopia/topicmaps/version}, __FILE__)

begin
  require 'hen'

  Hen.lay! {{
    :gem => {
      :name         => %q{ontopia-topicmaps},
      :version      => Ontopia::Topicmaps::VERSION,
      :summary      => %q{Query topic maps with Ontopia.},
      :author       => %q{Jens Wille},
      :email        => %q{jens.wille@gmail.com},
      :license      => %q{AGPL},
      :homepage     => :blackwinter,
      :platform     => 'java',
      :dependencies => %w[]
    }
  }}
rescue LoadError => err
  warn "Please install the `hen' gem. (#{err})"
end
