class Song
    attr_accessor :name, :artist, :genre

    @@all = []
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if !(genre.songs.include?(self))
            genre.songs << self
        end
    end

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        info = filename.split(" - ")
        # binding.pry
        artist = info [0]
        name = info [1]
        genre = info[2].gsub( ".mp3", "")
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
        new(name,artist,genre)
    end

    def self.create_from_filename(filename)
        file = Song.new_from_filename(filename)
        file.save
        file
    end

end