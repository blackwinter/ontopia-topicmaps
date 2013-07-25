describe Ontopia::Topicmaps::Topicmap do

  describe '::extract_query_projection' do

    example do
      Ontopia::Topicmaps::Topicmap.extract_query_projection(
        Ontopia::Topicmaps::Topicmap::QUERY[:all_topics]
      ).should == %w[TOPIC]
    end

    example do
      Ontopia::Topicmaps::Topicmap.extract_query_projection(
        Ontopia::Topicmaps::Topicmap::QUERY[:count_all_topics]
      ).should == %w[count(TOPIC)]
    end

    example do
      Ontopia::Topicmaps::Topicmap.extract_query_projection(
        'select $FOO, $BAR from $BAZ?'
      ).should == %w[FOO BAR]
    end

    example do
      Ontopia::Topicmaps::Topicmap.extract_query_projection(
        'SELECT $BAR, $FOO FrOm $BAZ?'
      ).should == %w[BAR FOO]
    end

    example do
      Ontopia::Topicmaps::Topicmap.extract_query_projection(
        '$FOO, $BAR'
      ).should be_nil
    end

  end

end
