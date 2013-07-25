# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ontopia-topicmaps"
  s.version = "0.0.2"
  s.platform = "java"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jens Wille"]
  s.date = "2013-07-25"
  s.description = "Query topic maps with Ontopia."
  s.email = "jens.wille@gmail.com"
  s.extra_rdoc_files = ["README", "COPYING", "ChangeLog"]
  s.files = ["lib/ontopia-topicmaps.rb", "lib/ontopia/topicmaps.rb", "lib/ontopia/topicmaps/packages.rb", "lib/ontopia/topicmaps/stringifiers.rb", "lib/ontopia/topicmaps/topicmap.rb", "lib/ontopia/topicmaps/version.rb", "COPYING", "ChangeLog", "README", "Rakefile", "spec/data/ItalianOpera.ltm", "spec/data/JillsMusic.xtm", "spec/data/ghn.xtm", "spec/ontopia/topicmaps/topicmap_spec.rb", "spec/ontopia/topicmaps_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/blackwinter/ontopia-topicmaps"
  s.licenses = ["AGPL"]
  s.rdoc_options = ["--charset", "UTF-8", "--line-numbers", "--all", "--title", "ontopia-topicmaps Application documentation (v0.0.2)", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Query topic maps with Ontopia."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
