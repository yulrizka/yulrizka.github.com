require 'pry'

module Jekyll
  module Converters
    class Markdown
      class RedcarpetParser
        
        module CommonMethods
          def add_code_tags(code, lang)
            @code_block_count ||= 0
            @code_block_count += 1
            
            code = code.sub(/<pre>/, "<pre>\n")
            code = code.sub(/<\/pre>/,"</pre>")
            code_array = code.lines
            for i in 1..code_array.length-2
              code_array[i] = "<br>" if code_array[i] == "\n"
              code_array[i] = "<div class=\"code-line\" id=\"C#{@code_block_count}L#{i}\">#{code_array[i].rstrip}</div>\n"
            end
            code_array.join()
          end
        end
        
        module WithPygments
          include CommonMethods
          def block_code(code, lang)
            require 'pygments'            
            
            lang = lang && lang.split.first || "text"
            highlight = add_code_tags(
              Pygments.highlight(code, :lexer => lang, :options => { :encoding => 'utf-8' }),
              lang
            )
            
            
            output = "<div class=\"code-listing\"><table><tr><td class=\"lines language-#{lang}\">"
            #binding.pry
            for i in 1..(highlight.lines.count-2)
              output += "<span class=\"line-number\">#{i}</span>"
            end
            output += '</td><td>'
            output += highlight.gsub!(/\n/,'')
            output += '</td></tr></table></div>'
          end
        end

      end
    end
  end
end