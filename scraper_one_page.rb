require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('https://www.leboncoin.fr/informatique/978004910.htm?ca=7_s')

if link = page.link_with(:text => "Envoyer un email") # As long as there is still a nextpage link...
  page = link.click
  puts "link found"

else # If no link left, then break out of loop
  puts "not found"
end

puts "Filling form"

form = page.forms.first

form['name'] = 'John doe'
form['email'] = 'john@doe.com'
form['body'] = 'lorem ipsum et labor'

page = form.submit

puts "Sent form"

page.search('#main h1').each do |h1|
  puts h1.text.strip
end
