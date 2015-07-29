# -*- encoding: utf-8 -*-
# stub: ontopia-topicmaps 0.0.4 java lib

Gem::Specification.new do |s|
  s.name = "ontopia-topicmaps"
  s.version = "0.0.4"
  s.platform = "java"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jens Wille"]
  s.date = "2015-07-29"
  s.description = "Query topic maps with Ontopia."
  s.email = "jens.wille@gmail.com"
  s.extra_rdoc_files = ["README", "COPYING", "ChangeLog"]
  s.files = ["COPYING", "ChangeLog", "README", "Rakefile", "lib/ontopia-topicmaps.rb", "lib/ontopia/topicmaps.rb", "lib/ontopia/topicmaps/packages.rb", "lib/ontopia/topicmaps/stringifiers.rb", "lib/ontopia/topicmaps/topicmap.rb", "lib/ontopia/topicmaps/version.rb", "spec/data/ItalianOpera.ltm", "spec/data/JillsMusic.xtm", "spec/data/ghn.xtm", "spec/ontopia/topicmaps/topicmap_spec.rb", "spec/ontopia/topicmaps_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/blackwinter/ontopia-topicmaps"
  s.licenses = ["AGPL-3.0"]
  s.post_install_message = "\nontopia-topicmaps-0.0.4 [2015-07-29]:\n\n* JRuby 9000 compatibility.\n\n"
  s.rdoc_options = ["--title", "ontopia-topicmaps Application documentation (v0.0.4)", "--charset", "UTF-8", "--line-numbers", "--all", "--main", "README"]
  s.requirements = ["Ontopia (http://ontopia.net/)"]
  s.rubygems_version = "2.4.8"
  s.summary = "Query topic maps with Ontopia."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hen>, [">= 0.8.2", "~> 0.8"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<hen>, [">= 0.8.2", "~> 0.8"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<hen>, [">= 0.8.2", "~> 0.8"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
