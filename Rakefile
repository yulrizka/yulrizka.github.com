require "rubygems"
require "bundler/setup"
require "stringex"

public_dir      = "./_site"
deploy_dir = "./_deploy"
deploy_branch   = "master"
source_branch   = "source"
source_dir      = "source"    # source file directory
posts_dir      = "_posts"    # source file directory
new_post_ext    = "markdown"  # default new post file extension when using the new_post task
new_page_ext    = "markdown"  # default new page file extension when using the new_page task


desc "deploy public directory to github pages"
multitask :push do
  puts "## Deploying branch to Github Pages "
  Rake::Task[:copy].invoke
  message = "Site updated at #{Time.now.utc}"
  cd "#{deploy_dir}" do
    system "git add ."
    system "git add -u"
    puts "\n## Commiting: Site updated at #{Time.now.utc}"    
    system "git commit -m \"#{message}\""
    puts "\n## Pushing generated #{deploy_dir} website"
    system "git push origin #{deploy_branch}"
    puts "\n## Github Pages deploy complete"
  end
    system "git add ."
    system "git add -u"
    puts "\n## Commiting Source: Site updated at #{Time.now.utc}"    
    system "git commit -m \"Source #{message}\""
    puts "\n## Pushing source"
    system "git push origin #{source_branch}"
    puts "\n## Github Pages deploy complete"
end

desc "Copy public directory to deploy"
task :copy do
  (Dir["#{deploy_dir}/*"]).each { |f| rm_rf(f) }
  #Rake::Task[:copydot].invoke(public_dir, deploy_dir)
  puts "\n## copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir
end

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
desc "Begin a new post in #{source_dir}/#{posts_dir}"
task :new_post, :title, :lang do |t, args|
  args.with_defaults(:title => 'new-post', :lang => 'en')
  title = args.title
  lang = args.lang
  mkdir_p "#{source_dir}/#{lang}/#{posts_dir}"

  filename = "#{source_dir}/#{lang}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
    post.puts "language: #{lang}"
    post.puts "comments: true"
    post.puts "tags: "
    post.puts "description: "
    post.puts "keywords: "
    post.puts "---"
  end
end