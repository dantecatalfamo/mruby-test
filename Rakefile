MRB_DIR = './mruby'
MRB_CONFIG = "#{MRB_DIR}/bin/mruby-config"
MRBC = "#{MRB_DIR}/bin/mrbc"

desc "Make sure mruby is compiled"
file "#{MRB_CONFIG}" do
  unless File.exists? "#{MRB_DIR}/Rakefile"
    sh "git submodule update --init"
  end
  Dir.chdir MRB_DIR do
    sh "rake"
  end
end

task set_params: MRB_CONFIG do
  CFLAGS = `#{MRB_CONFIG} --cflags`.chomp
  LDFLAGS = `#{MRB_CONFIG} --ldflags`.chomp
  LIBS = `#{MRB_CONFIG} --libs`.chomp
  LIBMRUBY = `#{MRB_CONFIG} --libmruby-path`.chomp
  CC = `#{MRB_CONFIG} --cc`.chomp
end

desc "Compile the main executable"
file "bin/test": ["src/test.c", "src/compiled.c", :set_params] do |t|
  sh "#{CC} #{CFLAGS} -o #{t.name} #{t.prerequisites.first} #{LDFLAGS} #{LIBS} #{LIBMRUBY}"
end

desc "Generate the .ccls file for Emacs autocomplete"
file ".ccls": MRB_DIR do |t|
  ruby 'ccls.rb'
end

desc "Compile src/compile.rb to mruby byte code"
file "src/compiled.c": ["src/compiled.rb", :set_params] do |t|
  sh "#{MRBC} -Bcompiled #{t.prerequisites.first}"
end

task default: ["bin/test", ".ccls"]
