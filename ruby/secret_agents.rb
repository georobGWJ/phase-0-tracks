# Pair Partner: Ashley Humphrey. GitHub ID: Von-Ashley
# 24 August 2016

=begin
ENCRYPT
1.get string from user
2.Start at index 0 and loop through every character
3. increment character by one value (.next)
4. delete first character(.delete)
5. increment the index value by one. (loop to next character)
6. if character == nil then exit loop. or use .length
7. Print string

DECRYPT
1. Define an reference string of "abcdefghijklmnopqrstuvwxyz"
2. Get string from user
3. Start at index 0 and loop through every character
4. Get character, get character index of character from reference string
5. Subract 1 from returned reference string index value
6. Set character in input string to str[0] = reference[reference value - 1]
7. Move to next character in input string until 'nil' is reached. 

=end

# TEST CODE
# puts "Type a word for encrypting:"
# encrypt_string = gets.chomp

def encrypt(string)

  idx = 0
  while idx < string.length

    if string[idx] == "z"
      string[idx] = "a"
    elsif string[idx] == " "
      string[idx] = " "
    else
      string[idx] = string[idx].next
    end 
    idx += 1
  end
  string
end

# TEST CODE
# puts encrypt(encrypt_string)

# TEST CODE
# puts "Type a word for decrypting:"
# decrypt_string = gets.chomp

def decrypt(string)

  ref_string = "abcdefghijklmnopqrstuvwxyz"

  idx = 0
  while idx < string.length
    if string[idx] == " "
      string[idx] = " "
    else
      ref_idx = ref_string.index(string[idx])
      string[idx] = ref_string[ref_idx - 1]
    end
    idx += 1
  end
  string
end

# TEST CODE
#puts decrypt(decrypt_string)

# TEST CODE
# This line passes the return value of the Encrypt method when it 
# is given the input "swordfish" to the Decrypt method, which then
# decrypts that return value. The result is getting "swordfish" back.
# puts decrypt(encrypt("swordfish"))

puts "Would you like to Encrypt or Decrypt today?"
answer = gets.chomp.downcase

puts "What is the password?"
password = gets.chomp.downcase

if answer == "encrypt"
  puts encrypt(password)
else
  puts decrypt(password)
end