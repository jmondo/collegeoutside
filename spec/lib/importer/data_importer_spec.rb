require 'spec_helper'

describe Importer::DataImporter do
  let(:importer) { Importer::DataImporter }
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
end
