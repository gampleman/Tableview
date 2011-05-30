require 'bundler'
module ::Bundler
  class GemHelper
    include Rake::DSL
  end
end

module ::RakeFileUtils
  extend Rake::FileUtilsExt
end
Bundler::GemHelper.install_tasks
