require 'pry'

class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        # Looks through directory, global to gather them all (even though they are just in the folder db / mp3s)
        # loads them all
        # returns a size
        Dir.glob("#{path}/*.mp3").collect{|file| file.gsub("#{path}/", "")}
    end

    def import
        files.each {|file| Song.create_from_filename(file)}
    end

end