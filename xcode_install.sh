#!/usr/bin/env ruby
require 'fileutils'
plist = ARGV[0] || "/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Resources/IDETextKeyBindingSet.plist"
puts "Editing #{plist}..."
pstr = File.read(plist)
chunk = File.read('XCodeCustomKeybindings.plist')
unless pstr.include?(chunk.lines.first)
  newplist = pstr.sub(%r{</dict>\n</plist>}, chunk+"</dict>\n</plist>\n")
  FileUtils.cp(plist, "#{plist}.bak")
  File.open(plist, 'w') {|f| f.write(newplist) }
  puts "...in case of problems, the original is at #{plist}.bak"
else
  puts "#{plist} already has a copy of #{chunk.lines.first}"
end
  