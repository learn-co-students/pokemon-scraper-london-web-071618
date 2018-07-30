class Pokemon

attr_accessor :name, :type, :db, :hp
attr_reader :id

@@all = []

  def initialize(id: id=nil ,name:, type:, db:, hp: hp=60)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
    @@all << self
  end

  def self.save(name, type, db)
    #Saves a new pokemon instance in the class Pokemon using the argument inputs.
    new_pokemon = Pokemon.new(name: name, type: type, db: db)
    # Inserts new pokemon instance as row into sql
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES(?,?)
        SQL
    db.execute(sql, name, type)
    #Updates ID of instance of pokemon in the Class, using id generated in SQL
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    new_pokemon
  end

  def self.all
    @@all
  end

  def self.find(id, db)
    # The find method creates a new Pokemon after selecting their row from the database by their id number.
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
      SQL
    #Get the information about the pokemon from SQL in an array
    pokemon = db.execute(sql, id)[0]
    #Create new pokemon instance based on info from array.
    Pokemon.new(id: id,name: pokemon[1],type: pokemon[2],db: db, hp: pokemon[3])
  end

  # pikachu.alter_hp(59, @db)
  # expect(Pokemon.find(1, @db).hp).to eq(59)
  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
      SQL

    db.execute(sql, hp, self.id)
  end

end
