require 'spec_helper'
include PaginateAlphabetically::ViewHelpers


module PaginateAlphabetically
  module ViewHelpers
    def request
      stub(:path => '')
    end
  end
end

describe 'View helpers' do
  before do
    @result = alphabetically_paginate([Thing.create!(:name => 'a')])
  end

  it "includes all the letters" do
    ('A'..'Z').each do |letter|
      @result.include?(letter).should be_true
    end
  end

  it "links to the available letters" do
    @result.include?('<a href="?letter=A">').should be_true
  end

  it "returns nothing when the collection is empty" do
    alphabetically_paginate([]).should == ''
  end

  it "does not link to letters that have no content" do
    @result.include?('href="?letter=B"').should be_false
  end

  it "wraps the letters as list items" do
    @result.include?('<li>B</li>').should be_true
  end

  it "wraps the result in a ul" do
    @result.include?('<ul class="pagination">').should be_true
  end

  it "allows the css class to be overridden" do
    result_with_class = alphabetically_paginate([Thing.create!(:name => 'a')], :class => 'overridden-class')
    result_with_class.include?('class="overridden-class"').should be_true
  end
end
