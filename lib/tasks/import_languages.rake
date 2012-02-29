require 'rubygems'
require 'open-uri'

# Rake task for importing language names from Unicode.org's CLDR repository
# (http://www.unicode.org/cldr/data/charts/summary/root.html).
# 
# It parses a HTML file from Unicode.org for given locale and saves the 
# Rails' I18n hash in the plugin +locale+ directory
# 
# Don't forget to restart the application when you add new locale to load it into Rails!
# 
# == Example
#   rake import:languages 'de'
# 
# The code is deliberately procedural and simple, so it's easily
# understandable by beginners as an introduction to Rake tasks power.
# See http://github.com/joshmh/cldr/tree/master/converter.rb for much more robust solution

namespace :import do

  desc "Import language codes and names for various languages from the Unicode.org CLDR archive. Depends on Hpricot gem."
  task :languages do
    begin
      require 'hpricot'
    rescue LoadError
      puts "Error: Hpricot library required to use this task (import:language_select)"
      exit
    end
    
    # TODO : Implement locale import chooser from CLDR root via Highline
    
    # Setup variables
    locale = ARGV[1]
    unless locale
      puts "\n[!] Usage: rake import:language_select de\n\n"
      exit 0
    end

    # ----- Get the CLDR HTML     --------------------------------------------------
    begin
      puts "... getting the HTML file for locale '#{locale}'"
      doc = Hpricot( open("http://www.unicode.org/cldr/data/charts/summary/#{locale}.html") )
    rescue => e
      puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
      exit 0
    end


    # ----- Parse the HTML with Hpricot     ----------------------------------------
    puts "... parsing the HTML file"
    languages = []
    doc.search("//tr").each do |row|
      if row.search("td[@class='n']") && 
         row.search("td[@class='n']").inner_html =~ /^nameslanguage$/ && 
         row.search("td[@class='g']").inner_html =~ /^[a-z]{2}$/
        code   = row.search("td[@class='g']").inner_text
        code   = code[-code.size, 2]
        name   = row.search("td[@class='v']").inner_text
        languages << { :code => code.to_sym, :name => name.to_s }
        print " ... #{name}"
      end
    end


    # ----- Prepare the output format     ------------------------------------------
    output =<<HEAD
#{locale}:
  languages:
HEAD
    languages.each do |language|
      output << "    \"#{language[:code]}\": \"#{language[:name]}\"\n"
    end
    output <<<<TAIL
TAIL

    
    # ----- Write the parsed values into file      ---------------------------------
    puts "\n... writing the output"
    filename = Rails.root.join('config', 'locales', "languages.#{locale}.yml")
    filename += '.new' if File.exists?(filename) # Append 'NEW' if file exists
    File.open(filename, 'w+') { |f| f << output }
    puts "\n---\nWritten values for the '#{locale}' into file: #{filename}\n"
    # ------------------------------------------------------------------------------
  end

end
