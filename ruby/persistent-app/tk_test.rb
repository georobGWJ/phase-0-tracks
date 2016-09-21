require 'tk'

root = TkRoot.new do 
  title "Hello, World!" 
  minsize(600,480)
end

frame = TkFrame.new
TkLabel.new(frame) do
   text 'Hello, World!'
   pack { padx 15 ; pady 15; side 'left' }
end

Tk.mainloop