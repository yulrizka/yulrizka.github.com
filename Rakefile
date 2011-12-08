require "rubygems"
require "bundler/setup"
require "stringex"

public_dir      = "./_site"
deploy_branch   = "master"
source_dir      = "source"    # source file directory
posts_dir      = "_posts"    # source file directory
new_post_ext    = "markdown"  # default new post file extension when using the new_post task
new_page_ext    = "markdown"  # default new page file extension when using the new_page task


desc "deploy public directory to github pages"
multitask :push do
  puts "## Deploying branch to Github Pages "
  message = "Site updated at #{Time.now.utc}"
  cd "#{public_dir}" do
    system "git add ."
    system "git add -u"
    puts "\n## Commiting: Site updated at #{Time.now.utc}"    
    system "git commit -m \"#{message}\""
    puts "\n## Pushing generated website"
    system "git push origin #{deploy_branch}"
    puts "\n## Github Pages deploy complete"
  end
    system "git add ."
    system "git add -u"
    puts "\n## Commiting Source: Site updated at #{Time.now.utc}"    
    system "git commit -m \"Source #{message}\""
    puts "\n## Pushing source"
    system "git push origin #{deploy_branch}"
    puts "\n## Github Pages deploy complete"
end

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
desc "Begin a new post in #{source_dir}/#{posts_dir}"
task :new_post, :title do |t, args|
  mkdir_p "#{source_dir}/#{posts_dir}"
  args.with_defaults(:title => 'new-post')
  title = args.title
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
    post.puts "comments: true"
    post.puts "categories: "
    post.puts "---"
  end
end