require 'open-uri'
require 'nokogiri'
require 'fileutils'

class ProjectEulerStatement

  def initialize(id)
    @url = "https://projecteuler.net/problem=#{id}"
  end

  def web_contents
    open(@url) { |f| f.read }
  end

  def problem
    xpath_str = "//div[@class='problem_content']/p"
    html = web_contents
    problem_contents = Nokogiri::HTML(html).xpath(xpath_str).children.map(&:text)

    problem_contents.join("\n\n")
  end

end

class PathFinder
  def initialize(path)
    @path = path
  end

  def make_path!
    return if File.directory?(parent_directory)

    directories = [parent_directory]
    directories << parent_directory(directories[-1]) until all_parents_exist?(directories)

    directories.reverse.each { |dirpath| FileUtils.mkdir_p(dirpath)}
  end

  private

  def parent_directory(current_path = @path)
    File.dirname(current_path)
  end

  def all_parents_exist?(array)
    File.directory? parent_directory(array[-1])
  end

end

class RecursiveFileWriter

  def initialize(root_path=nil, destination_path=nil)
    @root = root_path || `pwd`[0...-1]
    @dest = destination_path
  end

  def f
    Dir.glob(@root + "*/*.rb").each { |i| yield(i) }
  end

  def make_path(path)
    PathFinder.new(path).make_path!
  end

end

writer = RecursiveFileWriter.new("/Users/pkagey/personal/math/project_euler/ruby/scripts/")
writer.f do |i|
  path =  i.gsub("ruby/scripts", "problems")
  new_path = path[0...-2] + "txt"

  `mv #{path} #{new_path}`
  # problem_number = path[-6..-4].to_i
  # statement = ProjectEulerStatement.new(problem_number).problem
  # PathFinder.new(path).make_path!
  # File.write(path, statement)
end
