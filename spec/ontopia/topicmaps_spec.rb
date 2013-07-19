describe Ontopia::Topicmaps do

  describe 'JillsMusic' do

    before :all do
      @otm = otm('JillsMusic.xtm')
    end

    example { @otm.count.should == 274 }

    example { @otm.count('select count($TOPIC) from not(topic($TOPIC))?').should be_zero }

  end

  describe 'ItalianOpera' do

    example { otm('ItalianOpera.ltm').count.should == 2011 }

    example { otm('ItalianOpera.ltm').topics.size.should == 2011 }

    example { Ontopia::Topicmaps.count(data('ItalianOpera.ltm')).should == 2011 }

    example { Ontopia::Topicmaps.topics(data('ItalianOpera.ltm')).size.should == 2011 }

    example do
      Ontopia::Topicmaps.query(data('ItalianOpera.ltm'),
        '{ $TOPIC = puccini | $TOPIC = puccini-study-centre }?'
      ).sort.should == ['Centro studi Giacomo Puccini', 'Puccini, Giacomo']
    end

  end

  describe 'GHN' do

    before :all do
      @otm = otm('ghn.xtm')
      @dec = <<-EOT
direct-narrower-term($A, $B) :-
  HierarchicalRelation($A : broaderTermMember,
                       $B : narrowerTermMember).

narrower-term($A, $B) :- {
  direct-narrower-term($A, $B) |
  direct-narrower-term($A, $C), narrower-term($C, $B)
}.

narrower-or-equal-term($A, $B) :- {
  $A = $B | narrower-term($A, $B)
}.

direct-broader-term($A, $B) :-
  direct-narrower-term($B, $A).

broader-term($A, $B) :-
  narrower-term($B, $A).

broader-or-equal-term($A, $B) :-
  narrower-or-equal-term($B, $A).
      EOT
    end

    example do
      @otm.query(<<-EOT, @dec).should == %w[indexing]
select $TOPIC from
  Production($TOPIC : isProducing, $PRODUCT : isProductOf),
  broader-term(subject_indexes, $PRODUCT),
  broader-term(author_indexes, $PRODUCT),
  Usage($TOPIC : isUsing, classification_schemes : isInstrumentOf)?
      EOT
    end

    example do
      @otm.query(<<-EOT).should == %w[indexing]
import "http://psi.ontopia.net/tolog/string/" as s
#{@dec}
select $TOPIC from Production($TOPIC : isProducing, $PRODUCT : isProductOf),
  broader-term(subject_indexes, $PRODUCT),
  broader-term(author_indexes, $PRODUCT),
  Usage($TOPIC : isUsing, classification_schemes : isInstrumentOf)?
      EOT
    end

    example do
      @otm.query(<<-EOT, nil, :id).sort.should == %w[current_awareness_services information_services]
import "http://psi.ontopia.net/tolog/string/" as s

select $TOPIC from Production($_ : isProducing, $TOPIC : isProductOf),
topic-name($TOPIC, $PRODUCTNAME),
value($PRODUCTNAME, $PRODUCTSTRING),
s:contains($PRODUCTSTRING, "service")?
      EOT
    end

  end

end
