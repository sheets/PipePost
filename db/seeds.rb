# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	Plan.create([{ :plan_key=>"75s6",name: 'monthly',:price=>'12.99' },{ :plan_key=>"n45g",name: 'quarterly',:price=>'15.00' },{ :plan_key=>"f4yb",name: 'yearly',:price=>'130.00' },{ :plan_key=>"v3bm",name: 'lifetime',:price=>'1999.00' }])
	