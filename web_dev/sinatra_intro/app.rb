# require gems
require 'sinatra'
require 'sqlite3'

db = SQLite3::Database.new("students.db")
db.results_as_hash = true

# write a basic GET route
# add a query parameter
# GET /
get '/' do
  "#{params[:name]} is #{params[:age]} years old."
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