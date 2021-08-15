#!/usr/bin/env ruby

MRB_CONF = 'mruby/bin/mruby-config'
CCLS = '.ccls'

unless File.exist? MRB_CONF
  Dir.chdir 'mruby' do
    print 'mruby not compiled, run `make` now? [y/N] '
    abort 'Cannot run until mruby is compiled' unless gets.chomp =~ /^[yY]/
    system('make')
  end
end

cflags = `#{MRB_CONF} --cflags`
File.open(CCLS, 'w') do |file|
  file.puts('clang')
  file.puts(cflags.split.join("\n"))
end
