require 'rubygems'
require 'mechanize'
require 'diskcached'
require 'active_support/core_ext/module/delegation'
require 'active_record'
require 'sqlite3'

require_relative 'lib/xkom/disk'

disk_8tb = Xkom::Disk.new(8000, '255470-dysk-hdd-seagate-8tb-5900obr-128mb-archive')
puts disk_8tb.price_info

disk_6tb = Xkom::Disk.new(6000, '255467-dysk-hdd-seagate-6tb-5900obr-128mb-archive')
puts disk_6tb.price_info
