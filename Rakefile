require 'fileutils'
require 'plist'
require 'csv'

bundle_path = File.path './GB2260/data'
data_path = File.path './data'

task default: %w[help]

task :init do
  FileUtils.mkdir_p bundle_path
  puts "Init folder -- #{bundle_path}"
end

task :cleanup do
  FileUtils.rmdir bundle_path
  puts "Cleanup folder -- #{bundle_path}"
end

task :reinit => [:cleanup, :init]

task :update => [:reinit] do
  Dir["#{data_path.to_s}/*.tsv"].each do |file|
    plist_name = File.basename(file, '.*')
    plist_path = "#{bundle_path}/#{plist_name}.plist"
    print "Writing to file #{plist_path}... "
    plist = {revision: plist_name}
    data = {}
    CSV.read(file, { col_sep: "\t", headers: true}).each do |row|
      data[row['Code']] = row['Name']
    end
    plist.merge!({data: data})
    File.write(plist_path, plist.to_plist)
    puts "- Done!"
  end
end

task :help do

end
