# coding: utf-8
module Psp
  class FileResolver
    DEFAULT_PROJECT_NAME = 'project'.freeze

    attr_reader :path, :type

    def initialize(path, type:)
      @path = path
      @type = type
    end

    def directory
      @directory ||= relative_path(@path)
    end

    def size
      files.count
    end

    def plugin?
      @type == :plugin
    end

    def project?
      @type == :project
    end

    def files
      @files ||= Dir.glob(File.join(@path, '**', '*_spec.rb')).map do |full_path|
        relative_path(full_path)
      end
    end

    private

    def relative_path(full_path)
      Pathname.new(full_path)
        .relative_path_from(Pathname.new ROOT_PATH).to_s
    end
  end # class FileResolver
end # module Psp
