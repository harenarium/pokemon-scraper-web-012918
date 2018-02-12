require 'pry'
require "SQLite3"


class Pokemon
  attr_accessor :name, :type, :db, :id, :hp
#
  def initialize(attributes)
    @id = nil
    attributes.each{ |k,v|
      self.send("#{k}=",v)
    }
  end
#
#   def create_table
#     @db.execute("CREATE TABLE IF NOT EXISTS pokemon (id INTEGER PRIMARY KEY, name TEXT, type TEXT, db TEXT);")
#   end
#
  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?);",name,type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def alter_hp(hp, db)
    @hp = hp
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", self.hp, self.id)
    # db.execute("SELECT * FROM pokemon WHERE id = ?", self.id)[0][3]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = (?)
    SQL
    row = db.execute(sql,id)[0]
    Pokemon.new({id: row[0],name: row[1],type: row[2], hp: row[3], db: db}) ###needed to add , hp: row[3], db: db here
  end

end
# binding.pry
