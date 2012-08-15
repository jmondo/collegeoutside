require 'hpricot'
module Importer
  class DataImporter
    class << self

      def import_author_emails
        (file/'wp:author').each do |a|
          email = (a/'wp:author_email').text
          User.invite!(email: email)
        end
      end

      protected

      def file
        file = File.open(Rails.root.join 'lib/importer/collegeoutside.wordpress.2012-08-15.xml')
        Hpricot::XML(file)
      end

    end
  end
end
