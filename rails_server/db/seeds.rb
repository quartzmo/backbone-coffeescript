# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Suggestion.create!([
                       {subject: "Is this awesome or what?!", message: "That is all."},
                       {subject: "More Backbone 1234!", message: "+1"},
                       {subject: "jfhsjd", message: "djhvksjhfjds"}
                   ])
