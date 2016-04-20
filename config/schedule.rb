# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "~/Backup/log/cron_log.log"
#

set :job_template, "zsh -l -c ':job'"

job_type :rbenv_rake, %Q{export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)";cd :path && :task :output }

every 1.hours do
   rbenv_rake "backup perform -t dbname"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
