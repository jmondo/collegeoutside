module PathHelper
  def school_articles_path(school, *args)
    super(school.name, *args)
  end
end
