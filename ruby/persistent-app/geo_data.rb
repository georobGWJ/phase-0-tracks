# geo_data.rb
# A program that creates and manipulates a database of soil sample data,
# rig geologist data, borehole data and project data.
# Robert Turner

require 'sqlite3'
require 'tk' # I hope to implement a GUI, time permitting

current_db_name = nil

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

# Pretty Print Project Table Data
def pp_project(db)
  data = db.execute("SELECT * FROM projects")
  pp_string = ''
  data.each do |project|
    pp_string += "Project:   #{project['name']}\t"
    pp_string += "Client:   #{project['client']}\n"
  end
  pp_string
end

# Pretty Print Boreholes Table Data
def pp_borehole(db)
  data = db.execute("SELECT * FROM boreholes")
  pp_string = ''
  data.each do |bh|
    # proj_id = bh['project_id']
    # project = db.execute("SELECT * FROM projects WHERE id = ?", [proj_id])
    # pp_string += "Project:   #{project['name']}\t"
    pp_string += "Borehole:   #{bh['designation']}\t"
    pp_string += "Northing:   #{bh['northing']}\t"
    pp_string += "Easting:   #{bh['easting']}\t"
    pp_string += "Elevation:   #{bh['elevation']}\n"
  end
  pp_string
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

db = open_db("test.db")

words = pp_project(db)

# data = db.execute("SELECT * FROM projects")

#============================================================================
#    GUI CODE
#============================================================================
# Many thanks to http://www.tkdocs.com/tutorial/grid.html for learning
# tk and Ruby

# Create master window
#============================================================================
root = TkRoot.new do 
  title "Geotechnical Database" 
  minsize(1200,640)
end

# Create Parent container for tabs
tabs = Tk::Tile::Notebook.new(root) do
  #height 600
  place('height'=> 620, 'width'=> 1180, 'x'=> 10, 'y'=> 10)
end

# Create Tab Pages
#============================================================================
main_tab = Tk::Tile::Frame.new(tabs)
project_tab = Tk::Tile::Frame.new(tabs)
bh_tab = Tk::Tile::Frame.new(tabs)
geo_tab = Tk::Tile::Frame.new(tabs)
sample_tab = Tk::Tile::Frame.new(tabs)
query_tab = Tk::Tile::Frame.new(tabs)

# Populate Tabs container
tabs.add main_tab, :text => 'Welcome Page'
tabs.add project_tab, :text => 'Projects'
tabs.add bh_tab, :text => 'Boreholes'
tabs.add geo_tab, :text => 'Geologists'
tabs.add sample_tab, :text => 'Samples'
tabs.add query_tab, :text => 'Queries'

#============================================================================
# Populate Welcome Page Tab
#============================================================================
main_f1 = Tk::Tile::Frame.new(main_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

# welcome_f2 = Tk::Tile::Frame.new(project_tab) {borderwidth 1; relief "solid"}.
# grid( :column => 2, :row => 0, :sticky => 'nsew' )

Tk::Tile::Label.new(main_f1) {text '          '}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(main_f1) {text ' WELCOME! '}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(main_f1) {text '          '}.grid( :column => 2, :row => 2, :sticky => 'nsew')

#============================================================================
# Populate Projects Tab
#============================================================================
proj_f1 = Tk::Tile::Frame.new(project_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

proj_f2 = Tk::Tile::Frame.new(project_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 1, :sticky => 'nsew' )

# Widgets to add new project to database
tk_name = TkVariable.new
tk_client = TkVariable.new

Tk::Tile::Label.new(proj_f1) {text 'Add New Project to Database'}.
grid( :column => 0, :row => 0, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Separator.new(proj_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(proj_f1) {text 'Project Name: '}.
grid( :column => 1, :row => 2, :sticky => 'ew')
Tk::Tile::Entry.new(proj_f1) {width 50; textvariable tk_name}.
grid( :column => 3, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(proj_f1) {text 'Client Name: '}.
grid( :column => 1, :row => 3, :sticky => 'ew')
Tk::Tile::Entry.new(proj_f1) {width 50; textvariable tk_client}.
grid( :column => 3, :row => 3, :sticky => 'we' )

Tk::Tile::Separator.new(proj_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 4, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Button.new(proj_f1) {text 'Add Project'; 
command {add_project(db, tk_name.to_s, tk_client.to_s)}}.
grid( :column => 3, :row => 5, :sticky => 'ew')

# Widgets to display Project table data
project_data = view_table(db, "projects")

data = Tk::Tile::Label.new(proj_f2) { text pp_project(db) }.grid( :column => 0, :row => 0)

Tk::Tile::Button.new(proj_f2) {text 'Refresh'; command {data['text'] = pp_project(db)}}.
grid( :column => 3, :row => 3, :sticky => 'ew')



#============================================================================
# Populate Boreholes Tab
#============================================================================
bh_f1 = Tk::Tile::Frame.new(bh_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

bh_f2 = Tk::Tile::Frame.new(bh_tab) { }.
grid( :column => 2, :row => 0, :sticky => 'nsew' )

bh_f2_top = Tk::Tile::Frame.new(bh_f2) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'n' )

bh_f2_bottom = Tk::Tile::Frame.new(bh_f2) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 1, :sticky => 's' )

# Widgets to add new project to database
tk_desig = TkVariable.new
tk_north = TkVariable.new
tk_east = TkVariable.new
tk_elev = TkVariable.new
tk_proj = TkVariable.new

Tk::Tile::Label.new(bh_f1) {text 'Add New Borehole to Database'}.
grid( :column => 0, :row => 0, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Separator.new(bh_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(bh_f1) {text 'Designation: '}.
grid( :column => 1, :row => 2, :sticky => 'ew')
Tk::Tile::Entry.new(bh_f1) {width 30; textvariable tk_desig}.
grid( :column => 3, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(bh_f1) {text 'Northing: '}.
grid( :column => 1, :row => 3, :sticky => 'ew')
Tk::Tile::Entry.new(bh_f1) {width 30; textvariable tk_north}.
grid( :column => 3, :row => 3, :sticky => 'we' )

Tk::Tile::Label.new(bh_f1) {text 'Easting: '}.
grid( :column => 1, :row => 4, :sticky => 'ew')
Tk::Tile::Entry.new(bh_f1) {width 30; textvariable tk_east}.
grid( :column => 3, :row => 4, :sticky => 'we' )

Tk::Tile::Label.new(bh_f1) {text 'Elevation: '}.
grid( :column => 1, :row => 5, :sticky => 'ew')
Tk::Tile::Entry.new(bh_f1) {width 20; textvariable tk_elev}.
grid( :column => 3, :row => 5, :sticky => 'we' )

Tk::Tile::Label.new(bh_f1) {text 'Project ID: '}.
grid( :column => 1, :row => 6, :sticky => 'ew')
Tk::Tile::Entry.new(bh_f1) {width 30; textvariable tk_proj}.
grid( :column => 3, :row => 6, :sticky => 'we' )

Tk::Tile::Separator.new(bh_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 7, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Button.new(bh_f1) {text 'Add Borehole'; 
command {add_borehole(db, tk_desig.to_s, tk_north.to_s, tk_east.to_s, 
tk_elev.to_s, tk_proj.to_s)}}.
grid( :column => 3, :row => 8, :sticky => 'ew')

# Widgets to display Project table data
project_data = view_table(db, "boreholes")

data = Tk::Tile::Label.new(bh_f2_top) { text pp_borehole(db) }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(bh_f2_bottom) {text 'Refresh'; 
command {data['text'] = pp_borehole(db)}}.
grid( :column => 0, :row => 3, :sticky => 'ew')

#============================================================================
# Populate Geologists Tab
#============================================================================
geo_f1 = Tk::Tile::Frame.new(geo_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

geo_f2 = Tk::Tile::Frame.new(geo_tab) {borderwidth 1; relief "solid"}.
grid( :column => 2, :row => 0, :sticky => 'nsew' )

# Placeholder widgets for geo_f1
Tk::Tile::Label.new(geo_f1) {text 'northwest'}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(geo_f1) {text 'center'}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(geo_f1) {text 'southeast'}.grid( :column => 2, :row => 2, :sticky => 'nsew')

# Placeholder widgets for geo_f2
Tk::Tile::Label.new(geo_f2) {text 'northwest'}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(geo_f2) {text 'center'}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(geo_f2) {text 'southeast'}.grid( :column => 2, :row => 2, :sticky => 'nsew')

#============================================================================
# Populate Samples Tab
#============================================================================
sample_f1 = Tk::Tile::Frame.new(sample_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

sample_f2 = Tk::Tile::Frame.new(sample_tab) {borderwidth 1; relief "solid"}.
grid( :column => 2, :row => 0, :sticky => 'nsew' )

# Placeholder widgets for sample_f1
Tk::Tile::Label.new(sample_f1) {text 'northwest'}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(sample_f1) {text 'center'}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(sample_f1) {text 'southeast'}.grid( :column => 2, :row => 2, :sticky => 'nsew')

# Placeholder widgets for sample_f2
Tk::Tile::Label.new(sample_f2) {text 'northwest'}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(sample_f2) {text 'center'}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(sample_f2) {text 'southeast'}.grid( :column => 2, :row => 2, :sticky => 'nsew')

#============================================================================
# Populate Query Tab
#============================================================================
query_f1 = Tk::Tile::Frame.new(query_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

query_f2 = Tk::Tile::Frame.new(query_tab) {borderwidth 1; relief "solid"}.
grid( :column => 2, :row => 0, :sticky => 'nsew' )

# Placeholder widgets for query_f1
Tk::Tile::Label.new(query_f1) {text 'northwest'}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(query_f1) {text 'center'}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(query_f1) {text 'southeast'}.grid( :column => 2, :row => 2, :sticky => 'nsew')

# Placeholder widgets for query_f2
Tk::Tile::Label.new(query_f2) {text 'northwest'}.grid( :column => 0, :row => 0, :sticky => 'nsew')
Tk::Tile::Label.new(query_f2) {text 'center'}.grid( :column => 1, :row => 1, :sticky => 'nsew')
Tk::Tile::Label.new(query_f2) {text 'southeast'}.grid( :column => 2, :row => 2, :sticky => 'nsew')


Tk.mainloop