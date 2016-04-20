# encoding: utf-8
require 'backup-aliyun'

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:dbname, 'backup database') do
  ##
  # Archive [Archive]
  #
  # Adding a file or directory (including sub-directories):
  #   archive.add "/path/to/a/file.rb"
  #   archive.add "/path/to/a/directory/"
  #
  # Excluding a file or directory (including sub-directories):
  #   archive.exclude "/path/to/an/excluded_file.rb"
  #   archive.exclude "/path/to/an/excluded_directory
  #
  # By default, relative paths will be relative to the directory
  # where `backup perform` is executed, and they will be expanded
  # to the root of the filesystem when added to the archive.
  #
  # If a `root` path is set, relative paths will be relative to the
  # given `root` path and will not be expanded when added to the archive.
  #
  #   archive.root '/path/to/archive/root'
  #
  ##
  # MongoDB [Database]
  #
  database MongoDB do |db|
    db.username           = "backup"
    db.password           = "backup"
    db.host               = "127.0.0.1"
    db.port               = 27017
    db.ipv6               = false
    #db.only_collections   = ["only", "these", "collections"]
    db.additional_options = []
    db.lock               = false
    db.oplog              = false
  end

  # 配置阿里云 OSS 作为备份存储方式
  store_with 'Aliyun' do |aliyun|
    aliyun.access_key_id = 'key'
    aliyun.access_key_secret = 'secret'
    aliyun.bucket = 'bucket-name'
    aliyun.path = 'path'
    aliyun.area = 'cn-hangzhou'
    aliyun.keep = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #

  notify_by Slack do |slack|
    slack.on_success = true
    slack.on_warning = true
    slack.on_failure = true

    slack.webhook_url = ''
  end

end
