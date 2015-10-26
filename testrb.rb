
#
# ruby version 2.0 on windows has bug
# c:\ruby2\lib\ruby\site_ruby\2.0.0\rubygems\specification.rb line 722
#      Dir[File.join(dir, "*.gemspec")]   will error, occur program terminated
# must Dir[File.join(dir, "*.gemspec").b]
#
if ENV['OS'].to_s=~/windows/i && RUBY_VERSION.start_with?('2.0')
  # module Gem
  #   module DirMonkeyPatch
  #     def each_gemspec(dirs) # :nodoc:
  #       dirs.each do |dir|
  #         Dir[File.join(dir, "*.gemspec").b].each do |path| # add .b
  #           yield path.untaint
  #         end
  #       end
  #     end
  #   end
  #   class BasicSpecification
  #   end
  #   class Specification < BasicSpecification
  #     class << self
  #       prepend DirMonkeyPatch
  #     end
  #   end
  # end

  class Dir
    module DirMonkeyPatch
      def [] *args
        args = args.map { |x| x.b }
        super *args
      end
      def glob *args
        args = args.map { |x| x.b }
        super *args
      end
    end
    class << self
      prepend DirMonkeyPatch
    end
  end
end

# require 'enc/encdb'
# require 'rubygems'








print "\n---- [RUBY_VERSION, RUBY_PLATFORM] ----\n"
p [RUBY_VERSION, RUBY_PLATFORM]

print "\n---- [Encoding.default_internal, Encoding.default_external, __ENCODING__] ----\n"

p [Encoding.default_internal, Encoding.default_external, __ENCODING__]
# Encoding.default_external = Encoding::GBK
# p Encoding.default_external


print "\n---- require XXX ----\n"

gems = %w{enc/encdb openssl rubygems nokogiri psych racc abcdefg io-console win32ole }

gems.each do |gn|
  puts "require '#{gn}'"
  begin
    puts require gn
  rescue LoadError => e
    puts e
  end
end


print "\n---------------- test Dir[/*] ----------------------\n"
z = Dir['/*']
p z
p '--- -1'
puts [z[-1],  z[-1].encoding]
p z[-1].codepoints

p 'end.'
