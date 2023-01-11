# https://github.com/red-data-tools/red-datasets/blob/master/lib/datasets/cache-path.rb

module Bio
  class TwoBit
    class CachePath
      def initialize(id)
        @id = id
      end

      def base_dir
        Pathname(system_cache_dir).expand_path + "bio-twobit" + @id
      end

      def remove
        FileUtils.rmtree(base_dir.to_s, secure: true) if base_dir.exist?
      end

      private

      def system_cache_dir
        if ENV["XDG_CACHE_HOME"]
          return ENV["XDG_CACHE_HOME"]
        end
        case RUBY_PLATFORM
        when /mswin/, /mingw/
          ENV["LOCALAPPDATA"] || "~/AppData/Local"
        when /darwin/
          "~/Library/Caches"
        else
          "~/.cache"
        end
      end
    end
  end
end
