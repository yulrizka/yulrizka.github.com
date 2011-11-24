public_dir = "./_site"
deploy_dir = "./_deploy"
deploy_branch = "master"

desc "deploy public directory to github pages"
multitask :push do
  puts "## Deploying branch to Github Pages "
  Rake::Task[:copy].invoke
  cd "#{deploy_dir}" do
    system "git add ."
    system "git add -u"
    puts "\n## Commiting: Site updated at #{Time.now.utc}"
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m \"#{message}\""
    puts "\n## Pushing generated #{deploy_dir} website"
    system "git push origin #{deploy_branch} --force"
    puts "\n## Github Pages deploy complete"
  end
end

desc "Copy public directory to deploy"
task :copy do
  (Dir["#{deploy_dir}/*"]).each { |f| rm_rf(f) }
  #Rake::Task[:copydot].invoke(public_dir, deploy_dir)
  puts "\n## copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir
end