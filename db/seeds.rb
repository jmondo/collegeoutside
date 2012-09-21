# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

["winter", "spring", "summer", "fall"].each do |season|
  Season.find_or_create_by_name!(season)
end

["Tufts", "Babson"].each do |school|
  School.find_or_create_by_name!(school)
end

[
  "hiking",
  "running",
  "skiing",
  "biking",
  "climbing",
  "water",
  "winter",
  "camping",
  "gear",
  "yoga",
  "other"
].each do |activity|
  Activity.find_or_create_by_name!(activity)
end

CSV.foreach(Rails.root.join("db/data_files/states.csv"),
  headers: true,
  skip_blanks: true) do |state|
  State.find_or_create_by_name!(state["Name"]) do |s|
    s.abbreviation = state["Abbreviation"]
  end
end

[
  "pacific",
  "mountain",
  "southwest",
  "midwest",
  "southeast",
  "northeast"
].each do |region|
  Region.find_or_create_by_name!(region)
end

Importer::DataImporter.import_author_emails
