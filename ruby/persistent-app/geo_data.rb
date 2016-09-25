# geo_data.rb
# A program that creates and manipulates a database of soil sample data,
# rig geologist data, borehole data and project data.
# Robert Turner

require 'sqlite3'
require 'tk' # I hope to implement a GUI, time permitting

# Helper Methods

# Create a brand new empty database
def create_db(db_name)
  db = SQLite3::Database.new(db_name + ".db")
  db.results_as_hash = true

  # Create Project Table
  create_project_table = <<-SQL
  CREATE TABLE IF NOT EXISTS projects(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    client VARCHAR(255)
  )
  SQL

  # Create Geologists Table
  create_geo_table = <<-SQL
  CREATE TABLE IF NOT EXISTS geologists(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    company VARCHAR(255)
  )
  SQL

  # Create Borehole Table
  create_borehole_table = <<-SQL
  CREATE TABLE IF NOT EXISTS boreholes(
    id INTEGER PRIMARY KEY,
    designation VARCHAR(255) UNIQUE,
    northing REAL,
    easting REAL,
    elevation REAL,
    project_id INTEGER,
    FOREIGN KEY (project_id) REFERENCES projects(id)
  )
  SQL
  
  # Create Samples Table
  create_sample_table = <<-SQL
  CREATE TABLE IF NOT EXISTS samples(
    id INTEGER PRIMARY KEY,
    bh_id INTEGER, 
    logger_id INTEGER,
    depth REAL,
    USCS VARCHAR(63),
    color VARCHAR(127),
    wetness VARCHAR(63),
    percent_gravel INTEGER,
    percent_sand INTEGER,
    percent_fines INTEGER,
    plasticity VARCHAR(63),
    toughness VARCHAR(63),
    other VARCHAR(255),
    FOREIGN KEY (bh_id) REFERENCES boreholes(id),
    FOREIGN KEY (logger_id) REFERENCES geologists(id)
  )
  SQL

  db.execute(create_project_table)
  db.execute(create_geo_table)
  db.execute(create_borehole_table)
  db.execute(create_sample_table)

  db
end

# Load an existing database
def open_db(db_name)
  db = SQLite3::Database.open(db_name)
  db.results_as_hash = true
  db
end

# View all single table data
def view_table(db, table)
  db.execute("SELECT * FROM #{table}")
end

# Add Project to database
def add_project(db, name, client = nil)
  db.execute("INSERT INTO projects (name, client) VALUES (?, ?)", [name, client])
end

# Add Borehole to database
def add_borehole(db, desig, north, east, elev, proj_id)
  db.execute("INSERT INTO boreholes 
    (designation, northing, easting, elevation, project_id)
    VALUES (?, ?, ?, ?, ?)", [desig, north, east, elev, proj_id])
end

# Add Geologist to database
def add_geo(db, name, company = nil )
  db.execute("INSERT INTO geologists (name, company) 
              VALUES (?, ?)", [name, company])
end

# Add Sample to database
def add_sample(db, bh, geo, depth, uscs, color, wetness, pgravel, psand, pfines,
               toughness, plasticity, other)
  db.execute("INSERT INTO samples 
    (bh_id, logger_id, depth, USCS, color, wetness, percent_gravel, 
     percent_sand, percent_fines, plasticity, toughness, other)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
    [bh, geo, depth, uscs, color, wetness, pgravel, psand, pfines, toughness, 
     plasticity, other])

end


# TEST DRIVER CODE
# create_db("test")
db = open_db("test.db")

# db.execute("INSERT INTO projects (name, client) VALUES ('WLS Lee III', 'Duke')")
# db.execute("INSERT INTO projects (name, client) VALUES ('JWPCP', 'LACSD')")
# puts view_table(db, "projects")

# add_geo(db, "Rob Turner", "Worldwide Domination Inc.")
# puts view_table(db, "geologists")

# add_borehole(db, "BPH-02", 330, 120, 12, 1)
# puts view_table(db, "boreholes")

# add_sample(db, 1, 1, 15, "SP", "olive", "damp", 0, 97, 3,
#                nil, nil, "subrounded to rounded fine sand")
# puts view_table(db, "samples")

#================
#    GUI CODE
#================

# Create master window
root = TkRoot.new do 
  title "Geotechnical Database" 
  minsize(1200,640)
end

# Create Parent container for tabs
tabs = Tk::Tile::Notebook.new(root) do
  height 120
  place('height'=> 620, 'width'=> 1180, 'x'=> 10, 'y'=> 10)
end

# Create Tab Pages
main_tab = Tk::Tile::Frame.new(tabs);
project_tab = Tk::Tile::Frame.new(tabs);
bh_tab = Tk::Tile::Frame.new(tabs);
geo_tab = Tk::Tile::Frame.new(tabs);
sample_tab = Tk::Tile::Frame.new(tabs);
query_tab = Tk::Tile::Frame.new(tabs);

# Populate Tabs container
tabs.add main_tab, :text => 'Welcome Page'
tabs.add project_tab, :text => 'Projects'
tabs.add bh_tab, :text => 'Boreholes'
tabs.add geo_tab, :text => 'Geologists'
tabs.add sample_tab, :text => 'Samples'
tabs.add query_tab, :text => 'Queries'


Tk.mainloop