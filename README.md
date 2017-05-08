# 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77

This is a ruby script that takes a thread from the http://www.ilxor.com message board and turns it into a blog lol. 

An example of this high tech approach can be found when we use it to turn [this thread](http://www.ilxor.com/ILX/ThreadSelectedControllerServlet?boardid=40&threadid=105715&action=showall) in to [this blog](http://scoopsnoodle.com/77/).

Ilxor posts by the thread starter with underlined text ([u]underlined text using bbcode[/u]) will be a new post, and posts without underlined text will be comments, see [this thread](http://www.ilxor.com/ILX/ThreadSelectedControllerServlet?boardid=40&threadid=105715&action=showall) for examples.

Alls you have to do to prep the script is put a username and subtitle in lines 5 and 6 and insert your url into line 9. You'll want to append &action=showall to the url so that the thread's not truncated when it gets long. Then you can put it on a server and run a cron job or whatever. It uses the [nokogiri](https://rubygems.org/gems/nokogiri/versions/1.6.8) gem.

Do whatever you want to the css I GUESS even tho it was made by a professional designer ME.

:]