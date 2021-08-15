MRB_CONFIG = './mruby/bin/mruby-config'
CFLAGS = `#{MRB_CONFIG} --cflags`.chomp
LDFLAGS = `#{MRB_CONFIG} --ldflags`.chomp
LIBS = `#{MRB_CONFIG} --libs`.chomp
LIBMRUBY = `#{MRB_CONFIG} --libmruby-path`.chomp
CC = `#{MRB_CONFIG} --cc`.chomp

desc "Compile the main executable"
file "test": ["src/test.c"] do |t|
  sh "#{CC} #{CFLAGS} -o #{t.name} #{t.prerequisites.join(' ')} #{LDFLAGS} #{LIBS} #{LIBMRUBY}"
end

desc "Generate the .ccls file for Emacs autocomplete"
file ".ccls" do |t|
  ruby 'ccls.rb'
end

task default: ["test", ".ccls"]
