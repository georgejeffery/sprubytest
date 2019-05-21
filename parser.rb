require "byebug"

class LogParser
  def initialize(path)
    @log = File.readlines(path)
    @pages = @log.map { |line| line.strip.gsub(/\s.+/, "") }.group_by(&:itself).transform_values(&:count)
  end

  def allpageviews
    output = Hash[@pages.sort_by { |key, value| value }.reverse!]
    puts "Total Views"
    output.each do |line|
      puts "#{line[0]}, #{line[1]} views"
    end
  end

  def uniqueviews
    arry = []
    @pages.each_key do |key|
      @log.each do |line|
        if line.strip.gsub(/\s.+/, "") == key
          arry.push (line)
        end
      end
      puts "#{key} has #{arry.count} unique visits"
    end
  end

  parser = LogParser.new(*ARGV)
  parser.allpageviews
  parser.uniqueviews
end
