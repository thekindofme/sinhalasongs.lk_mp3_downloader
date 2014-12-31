require 'nokogiri'
require 'open-uri'

ARTIST='h-r-jothipala'
ARTIST_PAGE_URL_FORMAT='http://www.sinhalasongs.lk/sinhala-songs-download'

artist_page_doc = Nokogiri::HTML(open("#{ARTIST_PAGE_URL}/#{ARTIST}/"))
artist_name = artist_page_doc.css('span.titles').first.text

puts "Processing Artist: #{artist_name}"
`mkdir -p "#{artist_name}"`

artist_page_doc.css('li.page_item a').each do |song_page_link|
  song_name = song_page_link.text
  puts '=========================================================='
  puts "Processing #{song_name}"
  song_page_doc = Nokogiri::HTML(open(song_page_link.attributes['href']))
  song_url = song_page_doc.css('div.entry-content a').first.attributes['href']
  `curl -o "#{artist_name}/#{song_name.strip} - #{artist_name}.mp3" #{song_url}`
end%
