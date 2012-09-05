require 'hpricot'
module Importer
  class DataImporter
    class << self

      def import_author_emails
        (file/'wp:author').each do |a|
          email = (a/'wp:author_email').text
          login = (a/'wp:author_login').text
          author_hash[login] = email
          User.invite!(email: email)
        end
      end

      def author_hash
        @@author_hash ||= {}
      end

      def import_articles
        import_author_emails
        (file/'item').each do |a|
          title = (a/'title').text
          login = (a/'dc:creator').text
          art = Article.find_or_create_by_title(title)


          art.user = User.find_by_email(author_hash[login])
          art.body = (a/'content:encoded').text
          art.school = import_school
          art.save!(validate: false)
        end
      end

      protected

      def import_school
        @@school ||= School.find_or_create_by_name("Import School")
      end

      def file
        file = File.open(Rails.root.join 'lib/importer/collegeoutside.wordpress.2012-08-15.xml')
        Hpricot::XML(file)
      end

    end
  end
end
