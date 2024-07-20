# frozen_string_literal: true

require "open3"

module SetupVSCodeDevcontainer
  class GitConfig
    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def get(key)
      stdout, * = git_config(key)
      value = stdout&.strip
      value && value.empty? ? nil : value
    end

    def set(key, value)
      git_config(key, value)
    end

    class << self
      def default
        @default ||= new(location: nil)
      end

      def file(file)
        @file ||= new(location: file)
      end

      def location_args(location)
        case location
        when :global, :local, :system, :worktree
          ["--#{location}"]
        when nil
          []
        else
          ["--file", location.to_s]
        end
      end
    end

    private

    def git_config(*args)
      Open3.capture3("git", "config", *self.class.location_args(location), *args)
    end
  end
end
