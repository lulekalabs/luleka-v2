# Monkeypatch to add more directories to search path. Rails unfortunately makes
# this difficult to configure, but patching is easy.
class SourceAnnotationExtractor
  alias __find find
  def find(dirs=%w(app lib test config))
    __find(dirs)
  end
end

task :default => "test:fast"

namespace :test do

  Rake::TestTask.new(:fast => ["test:prepare"]) do |t|
    t.libs << "test"
    t.pattern = 'test/{unit,functional,integration}/**/*_test.rb'
  end
  Rake::Task['test:fast'].comment = "Run all tests together"

end
