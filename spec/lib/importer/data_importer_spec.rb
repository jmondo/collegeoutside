require 'spec_helper'

describe Importer::DataImporter do
  let(:importer) { Importer::DataImporter }
  describe "authors" do
    it "imports author names" do
      importer.import_author_emails
      User.count.should > 0
    end

    it "doesn't reimport authors if email already exists" do
      importer.import_author_emails
      user_count = User.count
      importer.import_author_emails
      User.count.should == user_count
    end

    it "creates a hash of email => creator" do
      importer.import_author_emails
      importer.author_hash["collegeoutside"].should == "slockwood09@gmail.com"
    end
  end

  describe "posts" do
    it "imports the post title, body, author" do
      importer.import_articles
      a = Article.order(:created_at).first
      a.title.should eql("Welcome!")
      a.body.should match("Hello and Welcome to College Outside!")
      a.user.should == User.find_by_email('slockwood09@gmail.com')
    end
  end
end
