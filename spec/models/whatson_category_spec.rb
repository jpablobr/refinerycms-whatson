require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe WhatsonCategory do
  before(:each) do
    @whatson_category = Factory.create(:whatson_category)
  end

  describe "validations" do
    it "requires title" do
      Factory.build(:whatson_category, :title => "").should_not be_valid
    end

    it "won't allow duplicate titles" do
      Factory.build(:whatson_category, :title => @whatson_category.title).should_not be_valid
    end
  end

  describe "whatson posts association" do
    it "has a posts attribute" do
      @whatson_category.should respond_to(:posts)
    end

    it "returns posts by published_at date in descending order" do
      first_post = @whatson_category.posts.create!({ :title => "Breaking News: Joe Sak is hot stuff you guys!!", :body => "True story.", :published_at => Time.now.yesterday })
      latest_post = @whatson_category.posts.create!({ :title => "parndt is p. okay", :body => "For a Kiwi.", :published_at => Time.now })

      @whatson_category.posts.first.should == latest_post
    end

  end

  describe "#post_count" do
    it "returns post count in category" do
      2.times do
        @whatson_category.posts << Factory.create(:whatson_post)
      end
      @whatson_category.post_count.should == 2
    end
  end
end
