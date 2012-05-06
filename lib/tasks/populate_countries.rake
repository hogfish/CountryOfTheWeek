#lib/tasks/populate_countries
desc "Imports the countries file into the Country table"
task :populate_countries => :environment do |task,args|
  sh "pwd"
  lines = File.new("Country-List.txt").readlines
  lines.each do |line|
    Module.const_get("Country").create(:name => line)
  end
end