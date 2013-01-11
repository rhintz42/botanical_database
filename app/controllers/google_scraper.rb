require 'rubygems'
require 'mechanize'
require 'open-uri'

agent = Mechanize.new
page = agent.get("http://plantfinder.sunset.com/plant-details.jsp?id=1000")
#puts /.*/.match(agent.page.search('//body').search('h3')[0])[0]
puts (page.body.match /<h3>(.*)<\/.*>/)[1]
puts (page.body.match /<h4>(.*)<\/h4>/m)[1]
#puts page.body
#puts agent.page.search('//body').search('h3')[0]
#puts /h/.match((agent.page.search('//body').search('h4'))[0])
