require 'pathname'
require 'rubygems'
require 'bundler'
require 'sprockets'
require 'coffee-script'

module Jekyll
  class SprocketsGenerator < Generator
    ROOT = Pathname(File.dirname(__FILE__)).join("../")
    SOURCE_DIR  = ROOT.join("source/_assets")
    BUILD_DIR   = ROOT.join("source/")    
    BUNDLES     = %w( application.js )
    
    safe true
    
    def generate(site)
      sprockets = Sprockets::Environment.new(ROOT) do |env|
        env.logger = Logger.new(STDOUT)
      end
      
      sprockets.append_path(SOURCE_DIR.join('javascripts').to_s)
      #sprockets.append_path(SOURCE_DIR.join('stylesheets').to_s)
      
      BUNDLES.each do |bundle|
          assets = sprockets.find_asset(bundle)
          if assets
            prefix, basename = assets.pathname.to_s.split('/')[-2..-1]
            FileUtils.mkpath BUILD_DIR.join(prefix)

            assets.write_to(BUILD_DIR.join(prefix, basename))
          end
       end
    end
  end

end