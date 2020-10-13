require 'yaml'

class Rules
  def self.load(filename)
    rules = YAML.load(File.read(filename))
    rules.map do |rule|
      "#{rule[:type]}Rule".camelize.constantize.new(rule)
    end
  end
end
