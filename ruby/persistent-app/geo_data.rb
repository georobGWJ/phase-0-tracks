# geo_data.rb
# A program that creates and manipulates a database of soil sample data,
# rig geologist data, borehole data and project data.
# Robert Turner

require 'sqlite3'
require 'tk' 

current_db_name = "example.db"

# Helper Methods

# Create a brand new empty database
def create_db(db_name)

  db = SQLite3::Database.new(db_name + ".db")
  db.results_as_hash = true
  current_db_name = (db_name + ".db")

  # Create Project Table
  create_project_table = <<-SQL
  CREATE TABLE IF NOT EXISTS projects(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    client VARCHAR(255)
  )
  SQL

  # Create Geologists Table
  create_geo_table = <<-SQL
  CREATE TABLE IF NOT EXISTS geologists(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    company VARCHAR(255)
  )
  SQL

  # Create Borehole Table
  create_borehole_table = <<-SQL
  CREATE TABLE IF NOT EXISTS boreholes(
    id INTEGER PRIMARY KEY,
    designation VARCHAR(255),
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

# Get all single table data
def view_table(db, table)
  db.execute("SELECT * FROM #{table}")
end

# Pretty Print Table Data
def pp_data(db, table, data = nil)
  if data == nil
    data = view_table(db, table)
  end
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


def pp_sample(db, sample_data = nil)
  if sample_data == nil
    sample_data = view_table(db, "samples")
  end
  pp_string = ''

  sample_data.each do |entry|

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
def add_project(db, proj_name, client)
  db.execute("INSERT INTO projects (name, client) VALUES (?, ?)", [proj_name, client])
end

# Add Borehole to database
def add_borehole(db, desig, north, east, elev, proj_id)
  db.execute("INSERT INTO boreholes 
    (designation, northing, easting, elevation, project_id)
    VALUES (?, ?, ?, ?, ?)", [desig, north, east, elev, proj_id])
end

# Add Geologist to database
def add_geo(db, geo_name, company)
  db.execute("INSERT INTO geologists (name, company) 
              VALUES (?, ?)", [geo_name, company])
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

def create_sql_helper(choice, operator, term, first_line_flag)
  sub_search_string = ""

  if (choice.to_s.length > 0  && operator.to_s.length > 0 && term.to_s.length > 0)
    if !first_line_flag
      sub_search_string += " AND "
    end

    sub_search_string += (choice.to_s + " " + operator.to_s + " ")
    if operator == "LIKE"
      sub_search_string += ("'%" + term.to_s + "%'")
    elsif term.to_i.to_s != term
      sub_search_string += ("'" + term.to_s + "'")
    else
      sub_search_string += term.to_s
    end  
  end
  sub_search_string
end

def create_sql_search(table, choice1, operator1, term1,
                      choice2, operator2, term2, choice3, operator3, term3)
  search_string = "SELECT * FROM #{table} WHERE "

  search_string += create_sql_helper(choice1, operator1, term1, true)
  search_string += create_sql_helper(choice2, operator2, term2, false)
  search_string += create_sql_helper(choice3, operator3, term3, false)
  
  search_string
end

#============================================================================
# INITIALIZE
#============================================================================

db = create_db("example")

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

main_f2 = Tk::Tile::Frame.new(main_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 1, :sticky => 'nsew' )

# Widget with Intro text
Tk::Tile::Label.new(main_f1) {text 'Welcome to the Geotechnical Database Frontend!'}.
grid( :column => 0, :row => 0, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Separator.new(main_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 10, :sticky => 'ew')

Tk::Tile::Label.new(main_f1) {text 'Here, you can create new geotechical 
databases or to add to existing geotechnical databases.'}.
grid( :column => 0, :row => 2, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(main_f1) {text 'All database files exist inside of the folder
where this Ruby file is located. It can only open files inside this folder and
new databases created will exist in this folder. By default, an example 
database file is opened for manipulation.'}.
grid( :column => 0, :row => 3, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(main_f1) {text 'The Query tab allows you to search the 
database tables using one to three search criteria.'}.
grid( :column => 0, :row => 4, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(main_f1) {text 'Have fun!'}.
grid( :column => 0, :row => 5, :columnspan => 5, :sticky => 'ew')

# Widgets to Open or Create a Database
new_db_name = TkVariable.new

Tk::Tile::Label.new(main_f2) {text 'Open or Create Database'}.
grid( :column => 0, :row => 0, :columnspan => 5, :sticky => 'w')

db_title = Tk::Tile::Label.new(main_f2) {text "Currently Open Database: #{current_db_name}"}.
grid( :column => 1, :row => 0, :sticky => 'e')

Tk::Tile::Separator.new(main_f2) { orient 'horizontal' }.
grid( :column => 0, :row => 2, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(main_f2) {text 'Database Name:'}.
grid( :column => 0, :row => 3, :sticky => 'ew')
Tk::Tile::Label.new(main_f2) {text '(Do not include file extension.)'}.
grid( :column => 0, :row => 4, :sticky => 'ew')
Tk::Tile::Entry.new(main_f2) {width 40; textvariable new_db_name}.
grid( :column => 1, :row => 3, :sticky => 'we' )

Tk::Tile::Button.new(main_f2) {text 'Open / Create'; 
command { db = create_db(new_db_name.to_s)
          db_title['text'] = "Currently Open Database: #{new_db_name + ".db"}"}}.
grid( :column => 3, :row => 5, :sticky => 'ew')



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
tab2_data = Tk::Tile::Label.new(proj_f2_top) { text pp_data(db, "projects") }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(proj_f2_bottom) {text 'Refresh'; 
command {tab2_data['text'] = pp_data(db, "projects", view_table(db, "projects"))}}.
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
bh_data = Tk::Tile::Label.new(bh_f2_top) { text pp_data(db, "boreholes") }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(bh_f2_bottom) {text 'Refresh'; 
command {bh_data['text'] = pp_data(db, "boreholes", view_table(db, "boreholes"))}}.
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
tk_geo_name = TkVariable.new
tk_company = TkVariable.new

Tk::Tile::Label.new(geo_f1) {text 'Add New Geologist to Database'}.
grid( :column => 0, :row => 0, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Separator.new(geo_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Label.new(geo_f1) {text 'Geo Name: '}.
grid( :column => 1, :row => 2, :sticky => 'ew')
Tk::Tile::Entry.new(geo_f1) {width 30; textvariable tk_geo_name}.
grid( :column => 3, :row => 2, :sticky => 'we' )

Tk::Tile::Label.new(geo_f1) {text 'Company: '}.
grid( :column => 1, :row => 3, :sticky => 'ew')
Tk::Tile::Entry.new(geo_f1) {width 30; textvariable tk_company}.
grid( :column => 3, :row => 3, :sticky => 'we' )

Tk::Tile::Separator.new(geo_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 4, :columnspan => 5, :sticky => 'ew')

Tk::Tile::Button.new(geo_f1) {text 'Add Geologist'; 
command {add_geo(db, tk_geo_name.to_s, tk_company.to_s)}}.
grid( :column => 3, :row => 5, :sticky => 'sew')

# Widgets to display Geologist table data
geo_data = Tk::Tile::Label.new(geo_f2_top) { text pp_data(db, "geologists") }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(geo_f2_bottom) {text 'Refresh'; 
command {geo_data['text'] = pp_data(db, "geologists", view_table(db, "geologists"))}}.
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
sample_data = Tk::Tile::Label.new(sample_f2_top) { text pp_sample(db) }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(sample_f2_bottom) {text 'Refresh'; 
command {sample_data['text'] = pp_sample(db, view_table(db, "samples"))}}.
grid( :column => 0, :row => 3, :sticky => 'ew')



#============================================================================
# Populate Query Tab
#============================================================================
query_f1 = Tk::Tile::Frame.new(query_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 0, :sticky => 'nsew' )

query_f2 = Tk::Tile::Frame.new(query_tab) {borderwidth 1; relief "solid"}.
grid( :column => 0, :row => 1, :sticky => 'nsew' )

# Widgets to add new Borehole to database
table = TkVariable.new
choice1 = TkVariable.new
operator1 = TkVariable.new
term1 = TkVariable.new
choice2 = TkVariable.new
operator2 = TkVariable.new
term2 = TkVariable.new
choice3 = TkVariable.new
operator3 = TkVariable.new
term3 = TkVariable.new


Tk::Tile::Label.new(query_f1) {text 'Search a Table'}.
grid( :column => 0, :row => 0, :columnspan => 10, :sticky => 'ew')

Tk::Tile::Separator.new(query_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 1, :columnspan => 10, :sticky => 'ew')

Tk::Tile::RadioButton.new(query_f1) {text 'Projects'; variable table; value 'projects'}.
grid( :column => 0, :row => 2, :sticky => 'w')

Tk::Tile::RadioButton.new(query_f1) {text 'Boreholes'; variable table; value 'boreholes'}.
grid( :column => 0, :row => 3, :sticky => 'w')

Tk::Tile::RadioButton.new(query_f1) {text 'Samples'; variable table; value 'samples'}.
grid( :column => 0, :row => 4, :sticky => 'w')

Tk::Tile::Separator.new(query_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 5, :columnspan => 10, :sticky => 'ew')

# Search term 1
Tk::Tile::Label.new(query_f1) {text 'Search Term 1: '}.
grid( :column => 0, :row => 6, :sticky => 'ew')

ch_combo1 = Tk::Tile::Combobox.new(query_f1) { textvariable choice1 }.
grid( :column => 1, :row => 6, :sticky => 'we' )
ch_combo1.values = ["", "project", "client", "designation", "northing", "easting", 
                 "depth", "elevation", "USCS", "color", "wetness",
                 "percent_gravel", "percent_sand", "percent_fines",
                 "plasticity", "toughness"]

op_combo1 =Tk::Tile::Combobox.new(query_f1) { textvariable operator1 }.
grid( :column => 2, :row => 6, :sticky => 'we' )
op_combo1.values = ["=", ">", ">=", "<", "<=", "LIKE"]

Tk::Tile::Entry.new(query_f1) { width 20; textvariable term1 }.
grid( :column => 3, :row => 6, :sticky => 'we' )

# Search term 2
Tk::Tile::Label.new(query_f1) {text 'Search Term 2: '}.
grid( :column => 0, :row => 7, :sticky => 'ew')

ch_combo2 = Tk::Tile::Combobox.new(query_f1) { textvariable choice2 }.
grid( :column => 1, :row => 7, :sticky => 'we' )
ch_combo2.values = ["", "project", "client", "designation", "northing", "easting", 
                 "depth", "elevation", "USCS", "color", "wetness",
                 "percent_gravel", "percent_sand", "percent_fines",
                 "plasticity", "toughness"]

op_combo2 =Tk::Tile::Combobox.new(query_f1) { textvariable operator2 }.
grid( :column => 2, :row => 7, :sticky => 'we' )
op_combo2.values = ["=", ">", ">=", "<", "<=", "LIKE"]

Tk::Tile::Entry.new(query_f1) { width 20; textvariable term2 }.
grid( :column => 3, :row => 7, :sticky => 'we' )

# Search term 3
Tk::Tile::Label.new(query_f1) {text 'Search Term 3: '}.
grid( :column => 0, :row => 8, :sticky => 'ew')

ch_combo3 = Tk::Tile::Combobox.new(query_f1) { textvariable choice3 }.
grid( :column => 1, :row => 8, :sticky => 'we' )
ch_combo3.values = ["", "project", "client", "designation", "northing", "easting", 
                 "depth", "elevation", "USCS", "color", "wetness",
                 "percent_gravel", "percent_sand", "percent_fines",
                 "plasticity", "toughness"]

op_combo3 =Tk::Tile::Combobox.new(query_f1) { textvariable operator3 }.
grid( :column => 2, :row => 8, :sticky => 'we' )
op_combo3.values = ["=", ">", ">=", "<", "<=", "LIKE"]

Tk::Tile::Entry.new(query_f1) { width 20; textvariable term3 }.
grid( :column => 3, :row => 8, :sticky => 'we' )

Tk::Tile::Separator.new(query_f1) { orient 'horizontal' }.
grid( :column => 0, :row => 9, :columnspan => 10, :sticky => 'ew')


search_string = ""
search_results = ""

results = Tk::Tile::Label.new(query_f2) { text " . . . " }.
grid( :column => 0, :row => 0)

Tk::Tile::Button.new(query_f1) {text 'SEARCH'; 

command { search_string = create_sql_search(table.to_s, choice1.to_s, 
          operator1.to_s, term1.to_s, choice2.to_s, operator2.to_s, term2.to_s,
          choice3.to_s, operator3.to_s, term3.to_s)
          search_results = db.execute(search_string)
          if table == "samples"
            results['text'] = pp_sample(db, search_results) 
          else
            results['text'] = pp_data(db, table, search_results)
          end }}.
grid( :column => 0, :row => 10, :columnspan => 10, :sticky => 'ew')



Tk.mainloop