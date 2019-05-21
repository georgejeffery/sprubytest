require "byebug"

class LogParser
  def initialize(path)
    @log = File.readlines(path)
  end

  def allpageviews
    # @log.each do |line|
    #   line = line.gsub!(/\s.+/, "")
    #   # byebug
    # end
    output = @log.map { |line| line.strip.gsub(/\s.+/, "") }.group_by(&:itself).transform_values(&:count)
    output = Hash[output.sort_by { |key, value| value }.reverse!]
    byebug
    puts "Total Views"
    output.each do |line|
      # byebug
      puts "#{line[0]}, #{line[1]} views"
    end
  end

  def uniqueviews
    output = @log.group_by(&:itself).transform_values(&:count)
    output = Hash[output.sort_by { |key, value| value }.reverse!]
    byebug
    puts "Unique Views"
    output.each do |line|
      # byebug
      puts "#{line[0].strip}, #{line[1]} views"
    end
  end

  parser = LogParser.new(*ARGV)
  parser.uniqueviews
end
