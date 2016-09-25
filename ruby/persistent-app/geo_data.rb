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

# Get all single table data
def view_table(db, table)
  db.execute("SELECT * FROM #{table}")
end

# Pretty Print Table Data
def pp_data(db, table)
  data = view_table(db, table)
  pp_string = ''

  data.each do |entry|
    entry.each do |id, val| 
      if id.is_a? String
      pp_string += "#{id}: #{val}\t| " 
      end 
    end
    pp_string += "\n"
  end
  pp_string
end


def pp_sample(db)
  data = data = view_table(db, "samples")
  pp_string = ''

  data.each do |entry|

    pp_string += "| ID: " + ('%-3s' % "#{entry['id']}")
    pp_string += "| Boring: " + ('%-3s' % "#{entry['bh_id']}")
    pp_string += "| Geo: " + ('%-3s' % "#{entry['logger_id']}")
    pp_string += "| " + ('%-20s' % "#{entry['USCS']}")
    pp_string += "| Color: " + ('%-10s' % "#{entry['color']}")
    pp_string += "| Moisture: " + ('%-5s' % "#{entry['wetness']}\n")
    pp_string += "| Gravel %: " + ('%-3s' % "#{entry['percent_gravel']}")
    pp_string += "| Sand %: " + ('%-3s' % "#{entry['percent_sand']}")
    pp_string += "| Fines %: " + ('%-3s' % "#{entry['percent_fines']}")
    pp_string += "| Plasticity: " + ('%-8s' % "#{entry['plasticity']}")
    pp_string += "| Toughness: " + ('%-8s' % "#{entry['toughness']}")
    pp_string += "| Other: " + ('%-30s' % "#{entry['other']}")

    pp_string += "\n\n"
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
  place('height'=> 620, 'width'=> 1200, 'x'=> 5, 'y'=> 5)
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

proj_f2 = Tk::Tile::Frame.new(project_tab) { }.
grid( :column => 1, :row => 0, :sticky => 'nsew' )

proj_f2_top = Tk::Tile::Frame.new(proj_f2) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'new' )

proj_f2_bottom = Tk::Tile::Frame.new(proj_f2) { }.
grid( :column => 0, :row => 1, :sticky => 's' )

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

data = Tk::Tile::Label.new(proj_f2_top) { text pp_data(db, "projects") }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(proj_f2_bottom) {text 'Refresh'; 
command {data['text'] = pp_data(db, "projects")}}.
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

bh_f2_bottom = Tk::Tile::Frame.new(bh_f2) { }.
grid( :column => 0, :row => 1, :sticky => 's' )

# Widgets to add new Borehole to database
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

# Widgets to display Borehole table data
project_data = view_table(db, "boreholes")

data = Tk::Tile::Label.new(bh_f2_top) { text pp_data(db, "boreholes") }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(bh_f2_bottom) {text 'Refresh'; 
command {data['text'] = pp_data(db, "boreholes")}}.
grid( :column => 0, :row => 3, :sticky => 'ew')

#============================================================================
# Populate Geologists Tab
#============================================================================
geo_f1 = Tk::Tile::Frame.new(geo_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

geo_f2 = Tk::Tile::Frame.new(geo_tab) { }.
grid( :column => 1, :row => 0, :sticky => 'nsew' )

geo_f2_top = Tk::Tile::Frame.new(geo_f2) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'new' )

geo_f2_bottom = Tk::Tile::Frame.new(geo_f2) { }.
grid( :column => 0, :row => 1, :sticky => 's' )

# Widgets to add new Geologist to database
tk_name = TkVariable.new
tk_company = TkVariable.new

Tk::Tile::Label.new(geo_f1) {text 'Add New Geologist to Database'}.
grid( :column => 0, :row => 0, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Separator.new(geo_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(geo_f1) {text 'Geo Name: '}.
grid( :column => 1, :row => 2, :sticky => 'ew')
Tk::Tile::Entry.new(geo_f1) {width 30; textvariable tk_name}.
grid( :column => 3, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(geo_f1) {text 'Company: '}.
grid( :column => 1, :row => 3, :sticky => 'ew')
Tk::Tile::Entry.new(geo_f1) {width 30; textvariable tk_company}.
grid( :column => 3, :row => 3, :sticky => 'we' )

Tk::Tile::Separator.new(geo_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 4, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Button.new(geo_f1) {text 'Add Geologist'; 
command {add_geo(db, tk_name.to_s, tk_company.to_s)}}.
grid( :column => 3, :row => 5, :sticky => 'sew')

# Widgets to display Geologist table data
project_data = view_table(db, "geologists")

data = Tk::Tile::Label.new(geo_f2_top) { text pp_data(db, "geologists") }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(geo_f2_bottom) {text 'Refresh'; 
command {data['text'] = pp_data(db, "geologists")}}.
grid( :column => 0, :row => 3, :sticky => 'ew')


#============================================================================
# Populate Samples Tab
#============================================================================
sample_f1 = Tk::Tile::Frame.new(sample_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

sample_f2 = Tk::Tile::Frame.new(sample_tab) { }.
grid( :column => 0, :row => 1, :sticky => 'nsew' )

sample_f2_top = Tk::Tile::Frame.new(sample_f2) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'new' )

sample_f2_bottom = Tk::Tile::Frame.new(sample_f2) { }.
grid( :column => 0, :row => 1, :sticky => 's' )

# Widgets to add new Borehole to database
tk_bh = TkVariable.new
tk_geo = TkVariable.new
tk_depth = TkVariable.new
tk_uscs = TkVariable.new
tk_color = TkVariable.new
tk_wet = TkVariable.new
tk_grav = TkVariable.new
tk_sand = TkVariable.new
tk_fine = TkVariable.new
tk_plast = TkVariable.new
tk_tough = TkVariable.new
tk_other = TkVariable.new


Tk::Tile::Label.new(sample_f1) {text 'Add New Sample to Database'}.
grid( :column => 0, :row => 0, :columnspan => 10, :sticky => 'ew')

Tk::Tile::Separator.new(sample_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 10, :sticky => 'ew')

Tk::Tile::Label.new(sample_f1) {text 'Borehole: '}.
grid( :column => 1, :row => 2, :sticky => 'ew')
Tk::Tile::Entry.new(sample_f1) {width 20; textvariable tk_bh}.
grid( :column => 2, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(sample_f1) {text 'Rig Geologist: '}.
grid( :column => 1, :row => 3, :sticky => 'ew')
Tk::Tile::Entry.new(sample_f1) {width 20; textvariable tk_geo}.
grid( :column => 2, :row => 3, :sticky => 'we' )

Tk::Tile::Label.new(sample_f1) {text 'Depth: '}.
grid( :column => 1, :row => 4, :sticky => 'ew')
Tk::Tile::Entry.new(sample_f1) {width 20; textvariable tk_depth}.
grid( :column => 2, :row => 4, :sticky => 'we' )

Tk::Tile::Label.new(sample_f1) {text 'USCS: '}.
grid( :column => 1, :row => 5, :sticky => 'ew')
p_combo =Tk::Tile::Combobox.new(sample_f1) { textvariable tk_uscs }.
grid( :column => 2, :row => 5, :sticky => 'we' )
p_combo.values = ["Well-Graded Gravel (GW)",
                  "Poorly-Graded Gravel (GP)",
                  "Silty Gravel (GM)",
                  "Well-Graded Sand (SW)",
                  "Poorly-Graded Sand (SP)",
                  "Silty Sand (SM)",
                  "Clayey Sand (SC)",
                  "Silt (ML)",
                  "Clay (CL)"]

Tk::Tile::Separator.new(sample_f1) { orient 'vertical' }.
grid( :column => 3, :row => 1, :rowspan => 7, :sticky => 'ns')

Tk::Tile::Label.new(sample_f1) {text 'Color: '}.
grid( :column => 4, :row => 2, :sticky => 'ew')
Tk::Tile::Entry.new(sample_f1) {width 20; textvariable tk_color}.
grid( :column => 5, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(sample_f1) {text 'Wetness: '}.
grid( :column => 4, :row => 3, :sticky => 'ew')
wet_combo =Tk::Tile::Combobox.new(sample_f1) { textvariable tk_wet }.
grid( :column => 5, :row => 3, :sticky => 'we' )
wet_combo.values = ["Wet", "Damp", "Dry"]

Tk::Tile::Label.new(sample_f1) {text 'Percent Gravel: '}.
grid( :column => 4, :row => 4, :sticky => 'ew')
TkSpinbox.new(sample_f1) {from 0.0; to 100.0; textvariable tk_grav}.
grid( :column => 5, :row => 4, :sticky => 'we' )

Tk::Tile::Label.new(sample_f1) {text 'Percent Sand: '}.
grid( :column => 4, :row => 5, :sticky => 'ew')
TkSpinbox.new(sample_f1) {from 0.0; to 100.0; textvariable tk_sand}.
grid( :column => 5, :row => 5, :sticky => 'we' )

Tk::Tile::Separator.new(sample_f1) { orient 'vertical' }.
grid( :column => 6, :row => 1, :rowspan => 7, :sticky => 'ns')

Tk::Tile::Label.new(sample_f1) {text 'Percent Fines: '}.
grid( :column => 7, :row => 2, :sticky => 'ew')
TkSpinbox.new(sample_f1) {from 0.0; to 100.0; textvariable tk_fine}.
grid( :column => 8, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(sample_f1) {text 'Plasticity: '}.
grid( :column => 7, :row => 3, :sticky => 'ew')
plast_combo =Tk::Tile::Combobox.new(sample_f1) { textvariable tk_plast }.
grid( :column => 8, :row => 3, :sticky => 'we' )
plast_combo.values = ["High", "Medium", "Low", "None"]

Tk::Tile::Label.new(sample_f1) {text 'Toughness: '}.
grid( :column => 7, :row => 4, :sticky => 'ew')
tough_combo =Tk::Tile::Combobox.new(sample_f1) { textvariable tk_tough }.
grid( :column => 8, :row => 4, :sticky => 'we' )
tough_combo.values = ["High", "Medium", "Low", "None"]

Tk::Tile::Label.new(sample_f1) {text 'Other Characteristics: '}.
grid( :column => 7, :row => 5, :sticky => 'ew')
Tk::Tile::Entry.new(sample_f1) {width 20; textvariable tk_other}.
grid( :column => 8, :row => 5, :sticky => 'we' )

Tk::Tile::Separator.new(sample_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 7, :columnspan => 10, :sticky => 'ew')

Tk::Tile::Button.new(sample_f1) {text 'Add Sample'; 
command {add_sample(db, tk_bh.to_s, tk_geo.to_s, tk_depth.to_s, tk_uscs.to_s, 
tk_color.to_s, tk_wet.to_s, tk_grav.to_s, tk_sand.to_s, tk_fine.to_s, 
tk_plast.to_s, tk_tough.to_s, tk_other.to_s)}}.
grid( :column => 5, :row => 8, :sticky => 'ew')

# Widgets to display Borehole table data
project_data = view_table(db, "boreholes")

data = Tk::Tile::Label.new(sample_f2_top) { text pp_sample(db) }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(sample_f2_bottom) {text 'Refresh'; 
command {data['text'] = pp_sample(db)}}.
grid( :column => 0, :row => 3, :sticky => 'ew')



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