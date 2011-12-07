public_dir = "./_site"
deploy_branch = "master"

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