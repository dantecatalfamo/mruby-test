MRB_CONFIG = './mruby/bin/mruby-config'
MRBC = './mruby/bin/mrbc'
CFLAGS = `#{MRB_CONFIG} --cflags`.chomp
LDFLAGS = `#{MRB_CONFIG} --ldflags`.chomp
LIBS = `#{MRB_CONFIG} --libs`.chomp
LIBMRUBY = `#{MRB_CONFIG} --libmruby-path`.chomp
CC = `#{MRB_CONFIG} --cc`.chomp

desc "Compile the main executable"
file "test": ["src/test.c", "src/compiled.c"] do |t|
  sh "#{CC} #{CFLAGS} -o #{t.name} #{t.prerequisites.first} #{LDFLAGS} #{LIBS} #{LIBMRUBY}"
end

desc "Generate the .ccls file for Emacs autocomplete"
file ".ccls" do |t|
  ruby 'ccls.rb'
end

desc "Compile src/compile.rb to mruby byte code"
file "src/compiled.c": "src/compiled.rb" do |t|
  sh "#{MRBC} -Bcompiled #{t.prerequisites.first}"
end

task default: ["test", ".ccls"]
