require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe WhatsonPost do
  let(:whatson_post ) { Factory.create(:whatson_post) }

  describe "validations" do
    it "requires title" do
      Factory.build(:whatson_post, :title => "").should_not be_valid
    end

    it "won't allow duplicate titles" do
      Factory.build(:whatson_post, :title => whatson_post.title).should_not be_valid
    end

    it "requires body" do
      Factory.build(:whatson_post, :body => nil).should_not be_valid
    end
  end

  describe "comments association" do

    it "have a comments attribute" do
      whatson_post.should respond_to(:comments)
    end

    it "destroys associated comments" do
      Factory.create(:whatson_comment, :whatson_post_id => whatson_post.id)
      whatson_post.destroy
      WhatsonComment.find_by_whatson_post_id(whatson_post.id).should == nil
    end
  end

  describe "categories association" do
    it "have categories attribute" do
      whatson_post.should respond_to(:categories)
    end
  end

  describe "tags" do
    it "acts as taggable" do
      whatson_post.should respond_to(:tag_list)

      #the factory has default tags, including 'chicago'
      whatson_post.tag_list.should include("chicago")
    end
  end

  describe "authors" do
    it "are authored" do
      WhatsonPost.instance_methods.map(&:to_sym).should include(:author)
    end
  end

  describe "by_archive scope" do
    before do
      @whatson_post1 = Factory.create(:whatson_post, :published_at => Date.new(2011, 3, 11))
      @whatson_post2 = Factory.create(:whatson_post, :published_at => Date.new(2011, 3, 12))

      #2 months before
      Factory.create(:whatson_post, :published_at => Date.new(2011, 1, 10))
    end

    it "returns all posts from specified month" do
      #check for this month
      date = "03/2011"
      WhatsonPost.by_archive(Time.parse(date)).count.should be == 2
      WhatsonPost.by_archive(Time.parse(date)).should == [@whatson_post2, @whatson_post1]
    end
  end

  describe "all_previous scope" do
    before do
      @whatson_post1 = Factory.create(:whatson_post, :published_at => Time.now - 2.months)
      @whatson_post2 = Factory.create(:whatson_post, :published_at => Time.now - 1.month)
      Factory.create(:whatson_post, :published_at => Time.now)
    end

    it "returns all posts from previous months" do
      WhatsonPost.all_previous.count.should be == 2
      WhatsonPost.all_previous.should == [@whatson_post2, @whatson_post1]
    end
  end

  describe "live scope" do
    before do
      @whatson_post1 = Factory.create(:whatson_post, :published_at => Time.now.advance(:minutes => -2))
      @whatson_post2 = Factory.create(:whatson_post, :published_at => Time.now.advance(:minutes => -1))
      Factory.create(:whatson_post, :draft => true)
      Factory.create(:whatson_post, :published_at => Time.now + 1.minute)
    end

    it "returns all posts which aren't in draft and pub date isn't in future" do
      WhatsonPost.live.count.should be == 2
      WhatsonPost.live.should == [@whatson_post2, @whatson_post1]
    end
  end

  describe "uncategorized scope" do
    before do
      @uncategorized_whatson_post = Factory.create(:whatson_post)
      @categorized_whatson_post = Factory.create(:whatson_post)

      @categorized_whatson_post.categories << Factory.create(:whatson_category)
    end

    it "returns uncategorized posts if they exist" do
      WhatsonPost.uncategorized.should include @uncategorized_whatson_post
      WhatsonPost.uncategorized.should_not include @categorized_whatson_post
    end
  end

  describe "#live?" do
    it "returns true if post is not in draft and it's published" do
      Factory.create(:whatson_post).live?.should be_true
    end

    it "returns false if post is in draft" do
      Factory.create(:whatson_post, :draft => true).live?.should be_false
    end

    it "returns false if post pub date is in future" do
      Factory.create(:whatson_post, :published_at => Time.now.advance(:minutes => 1)).live?.should be_false
    end
  end

  describe "#next" do
    before do
      Factory.create(:whatson_post, :published_at => Time.now.advance(:minutes => -1))
      @whatson_post = Factory.create(:whatson_post)
    end

    it "returns next article when called on current article" do
      WhatsonPost.last.next.should == @whatson_post
    end
  end

  describe "#prev" do
    before do
      Factory.create(:whatson_post)
      @whatson_post = Factory.create(:whatson_post, :published_at => Time.now.advance(:minutes => -1))
    end

    it "returns previous article when called on current article" do
      WhatsonPost.first.prev.should == @whatson_post
    end
  end

  describe "#category_ids=" do
    before do
      @cat1 = Factory.create(:whatson_category, :id => 1)
      @cat2 = Factory.create(:whatson_category, :id => 2)
      @cat3 = Factory.create(:whatson_category, :id => 3)
      whatson_post.category_ids = [1,2,"","",3]
    end

    it "rejects blank category ids" do
      whatson_post.categories.count.should == 3
    end

    it "returns array of categories based on given ids" do
      whatson_post.categories.should == [@cat1, @cat2, @cat3]
    end
  end

  describe ".comments_allowed?" do
    context "with RefinerySetting comments_allowed set to true" do
      before do
        RefinerySetting.set(:comments_allowed, { :scoping => 'whatson', :value => true })
      end

      it "should be true" do
        WhatsonPost.comments_allowed?.should be_true
      end
    end

    context "with RefinerySetting comments_allowed set to false" do
      before do
        RefinerySetting.set(:comments_allowed, { :scoping => 'whatson', :value => false })
      end

      it "should be false" do
        WhatsonPost.comments_allowed?.should be_false
      end
    end
  end

  describe "custom teasers" do
    it "should allow a custom teaser" do
      Factory.create(:whatson_post, :custom_teaser => 'This is some custom content').should be_valid
    end
  end
  
  describe ".teasers_enabled?" do
    context "with RefinerySetting teasers_enabled set to true" do
      before do
        RefinerySetting.set(:teasers_enabled, { :scoping => 'whatson', :value => true })
      end

      it "should be true" do
        WhatsonPost.teasers_enabled?.should be_true
      end
    end
    
    context "with RefinerySetting teasers_enabled set to false" do
      before do
        RefinerySetting.set(:teasers_enabled, { :scoping => 'whatson', :value => false })
      end

      it "should be false" do
        WhatsonPost.teasers_enabled?.should be_false
      end
    end
    
  end
  
end
