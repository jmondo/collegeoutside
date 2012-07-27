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
end
