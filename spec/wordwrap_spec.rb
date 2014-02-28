require 'spec_helper'
require 'wordwrap'

describe WordWrap do
  subject(:word_wrap) { WordWrap.new(wrap_column) }
  let(:wrap_column) { 4 }

  describe "#new" do
    it "should instantiate" do
      expect { word_wrap }.to_not raise_exception
    end
    context "when wrap column is not given" do
      it "raises an exception" do
        expect { WordWrap.new }.to raise_exception
      end
    end
    context "when wrap_column is a non-integer" do
      let(:wrap_column) { "foo" }
      it "raises an exception" do
        expect { word_wrap }.to raise_exception(/expected integer/i)
      end
    end
  end

  describe '.wrap' do
    subject(:wrap) { WordWrap.new(wrap_column).wrap(text) }
    let(:text) { '' }

    it "takes a string parameter" do
      expect { word_wrap.wrap("this is text") }.to_not raise_exception
    end
    it "raises an error on non-string parameters" do
      expect { word_wrap.wrap(5) }.to raise_exception(/expected string/i)
    end

    it { should eq('') }

    context "given one short word" do
      let(:text) { 'word' }
      it 'returns the string as is' do
        should eq(text)
      end
    end

    context 'given a longer phrase' do
      let(:text) { 'word word' }
      let(:wrap_column) { 5 }
      it 'wraps the text at the last space before the wrap length' do
        should eq("word\nword")
      end
      context 'given an even longer phrase' do
        let(:text) { 'word word word' }
        it { should eq("word\nword\nword") }
      end
      context 'and larger wrap column' do
        let(:text) { 'word word word' }
        let(:wrap_column) { 10 }
        it { should eq("word word\nword") }
      end
    end

    context "given long words without spaces" do
      let(:text) { 'wordword' }
      it { should eq("word\nword") }
    end

    context "given long words and spaces" do
      let(:text) { 'word word word' }
      let(:wrap_column) { 3 }
      it { should eq("wor\nd\nwor\nd\nwor\nd") }
    end
  end
end
