require 'pry'
require_relative "environment"

Scraper.new(@db).scrape

all_pokemon = @db.execute("SELECT * FROM pokemon;")

abra = @db.execute("SELECT * FROM pokemon WHERE name = 'Abra';")

Pokemon.save('Pikachu', 'electric', @db)
pikachu = Pokemon.find(1, @db)
pikachu.alter_hp(59, @db)
# expect(Pokemon.find(1, @db).hp).to eq(59)

binding.pry
