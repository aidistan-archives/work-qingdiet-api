namespace :bump do
  def bump(&block)
    # Before bumping
    Rake::Task['environment'].invoke
    load_constants

    # On bumping
    yield if block

    # After bumping
    update_constants
    commit_changes
  end

  def load_constants
    @version = %i[major minor patch].zip(QingDiet::VERSION.split('.').map(&:to_i)).to_h
    @version.define_singleton_method(:to_s, -> { values.join('.') })
    @vertime = Time.now.to_s[0...10]
    @vername = QingDiet::VERNAME

    @filepath = 'config/initializers/constants.rb'
  end

  def update_constants
    content = File.read(@filepath)
      .sub("VERSION = '#{QingDiet::VERSION}'", "VERSION = '#{@version}'")
      .sub("VERNAME = '#{QingDiet::VERNAME}'", "VERNAME = '#{@vername}'")
      .sub("VERTIME = '#{QingDiet::VERTIME}'", "VERTIME = '#{@vertime}'")
    File.open(@filepath, 'w') { |fout| fout.puts content }
  end

  def commit_changes
    `git add #{@filepath}`
    `git commit -m 'Bump to v#{@version}'`
    system('git commit --amend')
  end

  desc 'Create a commit bumping the patch number'
  task :patch do
    bump { @version[:patch] += 1 }
  end

  desc 'Create a commit bumping the minor number'
  task :minor do
    bump do
      @version[:minor] += 1
      @version[:patch]  = 0
    end
  end

  desc 'Create a commit bumping the major number'
  task :major do
    bump do
      @version[:major] += 1
      @version[:minor]  = 0
      @version[:patch]  = 0

      print 'A new version name is required: '
      @vername = STDIN.gets.chomp
    end
  end
end
