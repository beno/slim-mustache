module Slim
  module Mustache
    # Handle ~mustache syntax
    class Filter < ::Slim::Filter
      
      def on_slim_mustache(line, content)
        if match = line.match(/\A~([#\^]([^ ]*).*)/)
          [:multi, [:static, "{{#{match[1]}}}"], compile(content), [:static, "{{/#{match[2]}}}"]]
        else
          on_slim_interpolate(line)
        end
      end
      
      def on_slim_interpolate(string)
	      	matches = string.scan(/([^~]*)~([!>])?(\((.*)\)|([^ ]*[\w}])|\.)([^~]*)/)
	      	if matches.any?
		      	stack = [:multi]
		      	matches.each do |first, prefix, text, clean_text, _, last|
			      	prefix = "#{prefix} " if prefix
			      	text = clean_text if clean_text
			      	stack << [:multi, 
    			      	[:slim, :interpolate, first],
  			      	  [:static, "{{#{prefix}"],
  			      	  [:slim, :interpolate, text],
  			      	  [:static, "}}"],
  			      	  [:slim, :interpolate, last]]
					end
					stack
        else
          [:slim, :interpolate, string]
        end
      end
    end
    
  end
  
end
