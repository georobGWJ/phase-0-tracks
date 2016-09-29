# require gems
require 'sinatra'
require 'sqlite3'

db = SQLite3::Database.new("students.db")
db.results_as_hash = true

# write a basic GET route
# add a query parameter
# GET /
get '/' do
  field = params[:field]
  term = '"%' + "#{params[:term]}" + '%"'

  search = ""
  search += "<h3>To search the student database use the syntax:</h3>"
  search += "<h3>localhost:9393/?field=field_to_search&term=term_to search for</h3> <hr>"
  search += "<h4>Field: #{params[:field]}</h4>"
  search += "<h4>Term: #{params[:term]}</h4>"

  if !field || !term
    search += "<h5>You have not specified either a Field or a search Term.</h5>"
  elsif !(["id", "name", "campus", "age"].include?(field))
    search += "<h5>That Field does not exist in the database!</h5>"
  else 
    p "Inside of else"
    sql = "SELECT * FROM students WHERE #{field} LIKE #{term} "
    p sql
    students = db.execute(sql)
    p students
    response = ""
    students.each do |student|
      response << "ID: #{student['id']}<br>"
      response << "Name: #{student['name']}<br>"
      response << "Age: #{student['age']}<br>"
      response << "Campus: #{student['campus']}<br><br>"
    end

    search += "<h4>Results for searching Table #{field} for Term #{term} include: </h4> <hr>"
    search += response
  end
  search
end

# GET route that takes a name as a query parameter
# to say 'Great job!'
get '/great_job/' do
  name = params[:name]
  if name
    "<h2>Great job, #{name}!</h2>"
  else
    "<h2>Great job!</h2>"
  end
end


# GET Route that displays an address
get '/contact' do
  address = "<h3>Contact Information</h3><address>"
  address += "Malcolm 'Mal' Reynolds <br/>"
  address += "G-82659 Serenity (Firefly Class) <br/>"
  address += "Somewhere in the 'Verse. <br/></address>"
  address
end

# GET route that adds 2 numbers
get '/add/:num1/:num2' do
  sum = params[:num1].to_f + params[:num2].to_f
  "<h1> #{params[:num1]} + #{params[:num2]} = #{sum.round(5)} </h1>"
end


# write a GET route with
# route parameters
get '/about/:person' do
  person = params[:person]
  "#{person} is a programmer, and #{person} is learning Sinatra."
end

get '/:person_1/loves/:person_2' do
  "#{params[:person_1]} loves #{params[:person_2]}"
end

# write a GET route that retrieves
# all student data
get '/students' do
  students = db.execute("SELECT * FROM students")
  response = ""
  students.each do |student|
    response << "ID: #{student['id']}<br>"
    response << "Name: #{student['name']}<br>"
    response << "Age: #{student['age']}<br>"
    response << "Campus: #{student['campus']}<br><br>"
  end
  response
end

# write a GET route that retrieves
# a particular student

get '/students/:id' do
  student = db.execute("SELECT * FROM students WHERE id=?", [params[:id]])[0]
  student.to_s
end