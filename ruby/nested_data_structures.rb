# DBC Challenge 5.4
# Robert Turner is pretty awesome.

# Model a U.S. Navy fleet using a hash with nested ship details
fleet = {
  carrier: {"kitty_hawk" =>
              {aircraft: ["F-14 Tomcat", "A-6 Intruder", "E-2 Hawkeye"], 
               class: "Aircraft Carrier", 
               sailors: {captain: "CDR Halsey", 
                         best_pilots: ["Maverick", "Goose"]
                        }
              }
           },

  destroyer: {"fife" =>
              {aircraft: ["MH-60 Seahawk"], 
               class: "Destroyer", 
               sailors: {captain: "CDR Tamayo", 
                         best_radar_ops: ["Rob Turner", "Alan Grosny"]
                        }
              }
           },

 submarine: {"U.S.S. Dallas" =>
              {aircraft: [], 
               class: "Submarine", 
               sailors: {captain: "CDR Mancuso", 
                         best_sonar: ["Jones", "Beaumont"]
                        }
              }
           }

        }

# Call nested data structure data
puts "The U.S.S. Kitty Hawk is an #{fleet[:carrier]["kitty_hawk"]\
      [:class]}"
puts
puts "The secret best pilot (okay, an R.I.O.) was #{fleet[:carrier]\
      ["kitty_hawk"][:sailors][:best_pilots][1]}"
puts ("    R.I.O. is a Radar Intercept Officer, FYI")

puts
puts "Aircraft that can launch off of an Aircraft Carrier include:"
fleet[:carrier]["kitty_hawk"][:aircraft].each {|aircraft| puts aircraft + "s"}
puts
puts "The best Operations Specialist onboard the U.S.S. Fife was #{fleet[:destroyer]\
      ["fife"][:sailors][:best_radar_ops].first}"
puts "He went on to become the best geologist and then the best Ruby programmer!"
puts
puts "Meanwhile, aboard the #{fleet[:submarine].keys[0]}..."
puts "    A whale, Seaman #{fleet[:submarine]\
      ["U.S.S. Dallas"][:sailors][:best_sonar].last}, a whale,"
puts "    a marine mammal that knows a hell of a lot more about sonar than you do!"

