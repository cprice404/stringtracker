#!/usr/bin/env ruby

require 'optparse'
require 'colorize'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"

  opts.on("-t", "--target-dir target_dir", "Directory to search") do |t|
    options[:target_dir] = t
  end
end

begin
  optparse.parse!
  mandatory = {:target_dir => "--target-dir"}
  missing = mandatory.select{ |k,v| options[k].nil? }
  unless missing.empty?
    raise OptionParser::MissingArgument.new(missing.values.join(', '))
  end
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts $!.to_s
  puts optparse
  exit 1
end

STRING_MARKERS_REGEX = %r{^(.*)(\(log/|\(str\s|\(format\s|\([\w]+\. ")(.*)$}
I18N_MARKERS_REGEX = %r{\((i18n\/)?(tru|trs) }

num_translated = 0
num_untranslated = 0

Dir.glob(File.join(options[:target_dir], "**", "*.clj")).each do |path|
  File.open(path) do |f|
    line_num = 0
    f.each_line do |line|
      line_num += 1
      # puts "LOOKING AT LINE: #{line.green}"
      match = line.match(STRING_MARKERS_REGEX)
      if match
        i18n_match = line.match(I18N_MARKERS_REGEX)
        if i18n_match
          num_translated += 1
        else
          num_untranslated += 1
          puts "#{path.light_magenta}#{":".light_cyan}#{line_num.to_s.green}#{":".light_cyan}"
          puts "#{match[1]}#{match[2].light_red}#{match[3]}"
        end
      end
    end
  end
end

puts
puts
puts "-------------------------------------------------"
puts "Total number of strings found: #{num_translated + num_untranslated}"
puts "Number of translated strings: #{num_translated}"
puts "Number of untranslated string: #{num_untranslated}"