MRB_CONFIG = './mruby/bin/mruby-config'
CFLAGS = `#{MRB_CONFIG} --cflags`.chomp
LDFLAGS = `#{MRB_CONFIG} --ldflags`.chomp
LIBS = `#{MRB_CONFIG} --libs`.chomp
LIBMRUBY = `#{MRB_CONFIG} --libmruby-path`.chomp
CC = `#{MRB_CONFIG} --cc`.chomp

file "test": ["src/test.c"] do |t|
  sh "#{CC} #{CFLAGS} -o #{t.name} #{t.prerequisites.join(' ')} #{LDFLAGS} #{LIBS} #{LIBMRUBY}"
end

file ".ccls" do |t|
  ruby 'ccls.rb'
end

task default: ["test", ".ccls"]
