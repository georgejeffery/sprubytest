require "byebug"

class LogParser
  def initialize(path)
    @log = File.readlines(path)
    @pages = @log.map { |line| line.strip.gsub(/\s.+/, "") }.group_by(&:itself).transform_values(&:count)
    @uniques = {}
  end

  def print
    pages = Hash[@pages.sort_by { |key, value| value }.reverse!]
    puts "Total Views"
    pages.each do |line|
      puts "#{line[0]}, #{line[1]} views"
    end
    unique = Hash[@uniques.sort_by { |key, value| value }.reverse!]
    puts "-"
    puts "Unique Views"
    unique.each do |line|
      puts "#{line[0]}, #{line[1]} unique views"
    end
  end

  def uniqueviews
    @pages.each_key do |key|
      arry = []
      @log.each do |line|
        if line.strip.gsub(/\s.+/, "") == key
          arry.push (line)
        end
      end
      # byebug
      @uniques[key] = arry.uniq.count
    end
  end

  parser = LogParser.new(*ARGV)
  parser.uniqueviews
  parser.print
end
