require 'rubygems'
require 'mechanize'
require 'open-uri'

=begin
____________________________________________________________________________
Description-----------------------------------------------------------------
_____________________________________________________________________________
This program uses Mechanize to scrape information off of the plantfinder site
_____________________________________________________________________________
Objective-------------------------------------------------------------------
_____________________________________________________________________________
- Parsing
    This program should be able to parse all of the information off of the plantfinder
    site and store all of the values for each variable in a database.
- Versatility
    The program should be versatile enough to be able to do these things:
      * Be able to go through every plant page on plantfinder and get the relevent
          information
      * Share methods for invoking Mechanize with the other plant scrapers
- Updating
    The program should check to see if it has all the updated information by performing
    a checksum before it scrapes information. This should be performed like this:
      1) Check database to see if entry exists
      2) If entry exists, check the checksum of the previous page to the checksum of
          current page
      3) If Checksums are different, then update the information in the database
- Searching
    * Zipcode
    * Plant name
    * Plant color
    * Zones
    * Native plants
    * Water Usage
    * Sun types
- Growth
    The program should evolve into a RESTful application as well as a User reference
    with a growing database with decent UI and shows different resources for people
    to look up plant information
      * JSON
        - Sites should be able to query the site for useful plant information
      * User Reference
        - Have the fact section, then have other sites that people can look at for
          further information
_____________________________________________________________________________
Next Steps-------------------------------------------------------------------
_____________________________________________________________________________
- Parsing into Variables
    Need to get the variables of each plant and put them into well named variables
    in the program
    1) Plant name
    2) Scientific name
    3) Plant type
    4) Plant Zones
    5) Water Usage
    6) Plant descriptions

- Getting information from the descriptions
    See if it's doable to parse the information out of each plant, or if we
    should (By the descriptions) input the information manually.
      * Parsing
        This causes a lot of hassle because the information isn't really standardized.
        It might be easier to create a page for inputting information
      * Manually
        A basic manual page wouldn't be hard to create, and could use a split screen
        for users to look at while inputting information into the screen.
          - The split screen next to the form would be the description from the
            website that we scraped from
        If users edit or add stuff for the database, then give them points

_____________________________________________________________________________
Advancing-------------------------------------------------------------------
_____________________________________________________________________________
- Descriptions
    It's really important to give users good descriptions of plants while at the site,
    but need to make sure we aren't violating copywrite or anything.
      * (PREFERRED) Have the descriptions from the sites available
        - Give the sites FULL credit and add link to their website
        - Provide the main picture of the plant in front of the description from the site
        - Give each site thanks and links to their site on another page
      * (NOT PREFFERED) Don't have the description on the site
        - Instead just provide the links to the other sites for more information
        - This would be uglier
=end
agent = Mechanize.new
page = agent.get("http://plantfinder.sunset.com/plant-details.jsp?id=30")

path_plant_info =   "/html/body/
                    div[@class='pagewrap']/
                    div[@id='shadowWrapper']/
                    div[@id='container']/
                    div[@id='txtResizeArea']/
                    div[@id='contentOuter']/
                    div[@id='contentInner']/
                    div[@id='plantFinder']/
                    div[@id='maincol']/
                    div[@id='detailWrap']"

detail_wrap = page.parser.xpath(path_plant_info)

puts detail_wrap.to_s.index('<h3>')

first_strong = detail_wrap.to_s[detail_wrap.to_s.index('<strong>')..detail_wrap.to_s.length]

first_strong = first_strong["<strong>".length..first_strong.length]

index_end_strong = first_strong.index('</strong>')

index_next_strong = first_strong.index('<strong>')

first_plant = first_strong[0...index_end_strong]

puts first_plant

#second_strong = first_strong[first_strong.index('<strong>', 1)..first_strong.length]

#puts second_strong








=begin
THIS IS OLDER STUFF I WAS PLAYING WITH, BUT STILL GREAT TO HAVE FOR FUTURE

puts  page.parser.xpath(path_plant_info + "h3")

puts ' '

puts  page.parser.xpath(path_plant_info + "h4")

puts ' '

puts  page.parser.xpath(path_plant_info + "strong")

puts ' '

puts  page.parser.xpath(path_plant_info + "p")

puts ' '



puts  page.parser.xpath(path_plant_info + "div[@class='detailsleftCol']/
                        div[@class='plantInfo']/
                        div[@class='desc']")

puts ' '
=end





=begin
This is uglier code for scraping info off
puts /.*/.match(agent.page.search('//body').search('h3')[0])[0]
plant_name = (page.body.match /<h3>(.*)<\/.*>/)[1]
plant_sub_names = ((page.body.match /<h4>(.{,300})<\/h4>/m)[1]).split("\n")
puts plant_sub_names[2]
for name in plant_sub_names do
    plant_sub_names_2 = (name.match /^\s*(.{1,})$\s*/m)[1]
    if plant_sub_names_2.match /^\S/ then
        if plant_sub_names_2["<br />"] then
            plant_sub_names_2 = plant_sub_names_2.delete("<br />")
            
            #plant_sub_names_2 = plant_sub_names_2[0...plant_sub_names_2.length-7]
        end
        #puts plant_sub_names_2
    end
end

plant_description = ((page.body.match /<p><p>(.{,900})<\/p>/m))
plant_description = page.search('//body').search('detailsleftCol').search('//p')



puts plant_description[0]

puts  page.parser.xpath('/html/body/div/div/div/div/div/div/div/div/div/p/p').to_s.strip

puts ' '
=end




#plant_sub_names_2 = (plant_sub_names[1].match /^\s*(.{1,})$\s*/m)[1]
#puts plant_sub_names_2
#plant_sub_names_2 = (plant_sub_names[2].match /^\s*(.*)$\s*/m)[1]
#puts plant_sub_names_2

#puts plant_sub_names_2.split("\n")[0]

#puts page.body
#puts agent.page.search('//body').search('h3')[0]
#puts /h/.match((agent.page.search('//body').search('h4'))[0])
