# encoding: utf-8
require 'nokogiri'
require 'open-uri'

#put yr info in here
username = "Joe"
subtitletext = "It's Extremely Advanced Actually"

#scrape page
page = Nokogiri::HTML(open('http://www.ilxor.com/ILX/ThreadSelectedControllerServlet?boardid=40&threadid=105715&action=showall'))

#clean up html for ideal blogging
title = page.css(".headingblock h1")
title.add_class("site-title")
body = page.css("form")
body.css(".bookmarked, .unbookmarked, .permalink, .formsection, script, .howlongago, .functions, [name]").remove
body.css(".name a").remove_attr('href')
body.css("form").remove_attr('action')
body.css("form").remove_attr('method')
body.css('.name a').each { |node| node.replace(node.children) }


#change original posters class from name to op
op = body.css(".name").first.to_s
all = body.css(".name")
all.each { |node|
  if node.to_s == op
      if node['class'] == 'name'
        node['class'] = 'op'
      end
  end
}


=begin
if op.is_a? String 
  puts "string"
else
  puts "not"
end

strop = op.to_s

puts strop


#change original posters signature class from name to op
op = body.css(".name").first
op = op.text
body.css("span:contains('― #{op},')").each { |node| 
  if node['class'] == 'posterinfo'
    node.first_element_child['class'] = 'op' 
  end
}
=end

#impliment infos
body.css(".op").each { |node| node.content = username}
subtitle = "<div class='site-subtitle'>#{subtitletext}</div>"
footer = "<div class='footer'>Built with <a href='https://github.com/js108/77'>77</a> The Most Advanced Comunication Platform</div>"

#wrap posts that are by the op and have underlined text in a blog class to show theyre the post
body.xpath("//div[@class='message' and .//u and .//span[@class='op']]").each { |node| node["class"] = 'blog' }

#replace p u with blog-title div and title links
body.css(".blog p u").wrap("<div class='blog-title'>")
body.css(".blog p .blog-title u").wrap("<a href='foo'>")
body.css(".blog").each { |node| node.first_element_child.replace(node.first_element_child.inner_html) }
body.css(".blog-title a").each { |node| node.first_element_child.replace(node.first_element_child.inner_html) }

#give title links a value of title text
body.css(".blog-title a").attr("href") { |node| node.text.gsub(/\W/, '') }
body.css(".blog-title a").attr("href") { |node| ("#{node.attr("href")}.html") }

#linkify site title for blog pages
titletext = title.at_css(".site-title").inner_html
titlelink = title.at_css(".site-title").inner_html.replace("<h1 class='site-title'><a href='index.html'>#{titletext}</a></h1>")

#the head
head = "<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link rel='stylesheet' href='styles.css'>
  <script type='text/javascript' src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
  <title>#{title.text}</title>
</head>"

#jquery removes poster info from home page and link from title on post pages
deinfo = "<script>$('.posterinfo').remove();</script>"
delink = "<script>$('.blog-title a').contents().unwrap();</script>"

#reverse chronology of the posts
rblog = body.css(".blog").reverse

#generate the home page
open('index.html', 'w') { |f|
  f.puts head
  f.puts title
  f.puts subtitle
  rblog.each { |node| f.puts node }
  f.puts footer
  f.puts deinfo
}

#generate the post pages
blcount = 1
loop do 
  blpost = body.xpath("//div[@class='blog'][#{blcount}]","//div[@class='blog'][#{blcount}]/following-sibling::div[@class='message'][1 = count(preceding-sibling::div[@class='blog'][#{blcount}] | (//div[@class='blog'])[1])]")
  break if blpost.length == 0
  blurl = blpost.at_css(".blog-title a").attr("href")
  open( blurl, 'w') { |f|   
    f.puts head
    f.puts titlelink
    f.puts subtitle
    f.puts blpost
    f.puts footer
    f.puts delink
  }
  blcount += 1
end

