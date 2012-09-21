require 'spec_helper'

describe Article do
  describe "editing user" do
    let(:article) { FactoryGirl.build(:article, user: nil) }
    let!(:user) { FactoryGirl.create(:user) }

    it "sets editing user on create" do
      article.editing_user = user
      article.save!
      article.user.should eql(user)
    end

    it "can be left blank" do
      expect { article.save! }.to raise_error ActiveRecord::RecordInvalid
      article.user.should be_blank
    end

    it "does not replace given user" do
      article.user = FactoryGirl.create(:user)
      article.editing_user = user
      article.save!
      article.user.should_not eql(user)
    end

    it "does not change user of saved article" do
      article.user = FactoryGirl.create(:user)
      article.save!
      article.editing_user = user
      article.save!
      article.user.should_not eql(user)
    end
  end

  describe "activity sponsors" do
    let!(:activity) { FactoryGirl.create(:activity) }
    let!(:activity2) { FactoryGirl.create(:activity) }
    let(:sponsored_article_2_activities) { FactoryGirl.create(:published_article, sponsored: true, activities: [activity, activity2]) }
    let(:sponsored_article_first_activity) { FactoryGirl.create(:published_article, sponsored: true, activities: [activity]) }
    let(:sponsored_article_second_activity) { FactoryGirl.create(:published_article, sponsored: true, activities: [activity2]) }
    let(:sponsored_article_other_activity) { FactoryGirl.create(:published_article, sponsored: true) }
    let(:unpublished_sponsored_article) { FactoryGirl.create(:article, sponsored: true, activities: [activity]) }
    let!(:article) { FactoryGirl.create(:published_article, activities: [activity, activity2]) }
    it "should only show sponsored articles from the current activity(ies)" do
      sponsored_article_other_activity
      sponsored_article_first_activity
      sponsored_article_second_activity
      article.activity_sponsors.to_a.length.should eql(2)
      article.activity_sponsors.should include sponsored_article_first_activity
      article.activity_sponsors.should include sponsored_article_second_activity
    end

    it "only shows published sponsors" do
      unpublished_sponsored_article
      article.activity_sponsors.should be_empty
    end

    it "does not duplicate sponsors" do
      sponsored_article_2_activities
      article.activity_sponsors.should == [sponsored_article_2_activities]
    end
  end

  describe "recent by activity" do
    let!(:activity) { FactoryGirl.create(:activity) }
    let!(:activity2) { FactoryGirl.create(:activity) }

    let!(:article_2_activities) { FactoryGirl.create(:published_article, activities: [activity, activity2]) }
    let!(:article_first_activity) { FactoryGirl.create(:published_article, activities: [activity]) }
    let!(:article_second_activity) { FactoryGirl.create(:published_article, activities: [activity2]) }

    it "should show articles for a set of activities" do
      Article.recent_by_activities([activity]).to_a.length.should eql(2)
      Article.recent_by_activities([activity]).should include(article_2_activities)
      Article.recent_by_activities([activity]).should include(article_first_activity)
    end

    it "should return articles in reverse chron by published_at" do
      Article.recent_by_activities([activity])[1].should == (article_2_activities)
      Article.recent_by_activities([activity])[0].should == (article_first_activity)
    end
  end
end
