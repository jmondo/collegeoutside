# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
  "other"
].each do |activity|
  Activity.find_or_create_by_name!(activity)
end
