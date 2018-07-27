require 'pry'

class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  def initialize(id: nil, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @hp = hp
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type) VALUES (?, ?);
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?;
    SQL
    data = db.execute(sql, id)[0]
    return Pokemon.new(id:data[0], name:data[1], type:data[2], db:db, hp:data[3])
  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL
      @db.execute(sql, new_hp, self.id)[0]
  end
end
