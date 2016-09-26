require 'tk'

root = TkRoot.new do 
  title "Hello, World!" 
  minsize(600,480)
end

menu_click = Proc.new {
  Tk.messageBox(
    'type'    => "ok",  
    'icon'    => "info",
    'title'   => "Title",
    'message' => "Message"
  )
}

menu_bar = TkMenu.new(root)

menu_bar.add('command',
              'label'     => "New...",
              'command'   => menu_click,
              'underline' => 0)
menu_bar.add('command',
              'label'     => "Open...",
              'command'   => menu_click,
              'underline' => 0)
menu_bar.add('command',
              'label'     => "Close",
              'command'   => menu_click,
              'underline' => 0)
menu_bar.add('separator')
menu_bar.add('command',
              'label'     => "Save",
              'command'   => menu_click,
              'underline' => 0)
menu_bar.add('command',
              'label'     => "Save As...",
              'command'   => menu_click,
              'underline' => 5)
menu_bar.add('separator')
menu_bar.add('command',
              'label'     => "Exit",
              'command'   => menu_click,
              'underline' => 3)

the_menu = TkMenu.new
the_menu.add('cascade',
             'menu'  => menu_bar,
             'label' => "Files")

root.menu(the_menu)

frame1 = TkFrame.new
TkLabel.new(frame1) do
  text 'Hello, World!'
  pack { padx 15 ; pady 15; side 'left' }
end

#frame2 = TkFrame.new
  

Tk.mainloop