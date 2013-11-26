class Book
  BOOKS =
    {
      dickens: [1023, 766, 1400, 968, 967, 730, 580, 98],
      doyle: [1661, 2852, 834, 221, 2097, 244],
      austen: [158, 141, 1342, 161],
      wilde: [174],
      carroll: [11, 12],
      joyce: [2814, 4217, 4300],
      tolstoy: [1399, 2600],
      melville: [2701],
      wells: [5230, 159, 36],
      irving: [41],
      kipling: [236],
      wodehouse: [8164, 10554],
      stoker: [345],
      shelley: [84],
      jerome: [856, 849, 868, 308],
      bronte: [768], 
    }
  def self.retrieve
    BOOKS.values.reduce(:|).map do |pg|
      path = "./books/#{pg}.txt"
      process(pg, path) unless File.exists?(path)
      path
    end
  end
  def self.process(pg, target)
    source = "./books/#{pg}.htm"
    download(pg, source) unless File.exists?(source)
    doc = Nokogiri::HTML(File.read(source))
    emit = false
    lines = doc.search('p').map do |e|
      begin
        line = e.text.strip
        line.gsub!(/\n */, ' ')
        line.gsub!(/\r/, '')
        line.strip
      rescue
        ""
      end
    end
    lines.delete_if { |line| line.length <= 1 }
    open(target, 'wb') do |file|
      file.write(lines.join("\n"))
    end
  end
  def self.download(pg, path)
    require 'open-uri'
    open(path, 'wb') do |file|
      uri = "http://www.gutenberg.org/files/#{pg}/#{pg}-h/#{pg}-h.htm"
      open(uri) { |url| file.write(url.read) }
    end
  end
end
