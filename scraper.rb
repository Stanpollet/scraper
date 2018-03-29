require 'mechanize'

mechanize = Mechanize.new
# url to change according to the research
url = ''
page = mechanize.get(url)

links = page.links.map(&:href)
counter = 0

puts "lets be malicious biiiaaaatch"

10.times do |n|

  puts "scraping page #{n+1}"

  links.each do |link|
    if /\d{10}\./.match(link)
      counter +=1

      page = mechanize.get("#{link}")

      if link = page.link_with(:text => "Envoyer un email") # As long as there is still a nextpage link...
        page = link.click
      else # If no link left, then break out of loop
        puts "not found"
      end

      form = page.forms.first

      # EMAIL FORM INPUTS
      form['name'] = 'John doe'
      form['email'] = 'john@doe.com'
      form['body'] = 'lorem ipsum et labor'

      page = form.submit

      # page.search('#main h1').each do |h1|
      #   puts h1.text.strip
      # end
    end
  end

  puts "Sent #{counter} emails"

  links.each do |link|
    if /o="#{n+1}"\b/.match(link) # Find pagination links -- regex match --
      link.click
      puts "Found pagination link, click"
    end
  end

end

