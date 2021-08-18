MRB_DIR = './mruby'
MRB_CONFIG = "#{MRB_DIR}/bin/mruby-config"
MRBC = "#{MRB_DIR}/bin/mrbc"
TARGET = "bin/test"

desc "Compile mruby"
task :mruby do
  unless File.exists? "#{MRB_DIR}/Rakefile"
    sh "git submodule update --init"
  end
  Dir.chdir MRB_DIR do
    sh "rake"
  end
end

desc "Ensure the mruby configuration script exists"
file MRB_CONFIG do
  Rake::Task[:mruby].invoke
end

task set_params: MRB_CONFIG do
  CFLAGS = `#{MRB_CONFIG} --cflags`.chomp
  LDFLAGS = `#{MRB_CONFIG} --ldflags`.chomp
  LIBS = `#{MRB_CONFIG} --libs`.chomp
  LIBMRUBY = `#{MRB_CONFIG} --libmruby-path`.chomp
  CC = `#{MRB_CONFIG} --cc`.chomp
end

desc "Compile src/compile.rb to mruby byte code"
file "src/compiled.c": ["src/compiled.rb"] do |t|
  Rake::Task[:set_params].invoke
  sh "#{MRBC} -Bcompiled #{t.prerequisites.first}"
end

desc "Compile the main executable"
file TARGET => ["src/test.c", "src/compiled.c"] do |t|
  Rake::Task[:set_params].invoke
  sh "#{CC} #{CFLAGS} -o #{t.name} #{t.prerequisites.first} #{LDFLAGS} #{LIBS} #{LIBMRUBY}"
end

desc "Generate the .ccls file for Emacs autocomplete"
file ".ccls": MRB_CONFIG do |t|
  ruby 'ccls.rb'
end

desc "Run the compiled binary"
task run: TARGET do
  sh TARGET
end

task default: ["bin/test", ".ccls"]
