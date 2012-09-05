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
      a.body.should match("<p>Hello and Welcome to College Outside!</p>")
      a.user.should == User.find_by_email('slockwood09@gmail.com')
    end
    it "adds the original publish date to end of article" do
      importer.import_articles
      a = Article.order(:created_at).first
      a.body.index("<p>Originally published Wed, 21 Dec 2011 20:40:16 +0000</p>").should be_present
    end
    it "removes captions from images" do
      importer.import_articles
      a = Article.find_by_title("What to Wear: Winter Hiking")
      a.body.index('[caption id="attachment_55" align="alignright" width="130" caption="Patagonia R1"]').should be_nil
      a.body.index('[/caption]').should be_nil
      a.body.index('<img class="wp-image-55  " title="35607541" src="http://www.collegeoutside.com/wp-content/uploads/2011/12/35607541-300x300.jpg" alt="" width="130" height="130" />').should_not be_nil
    end
  end
end
