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

puts "Type a word for encrypting:"
encrypt_string = gets.chomp

def encrypt(string)
  # 2.Start at index 0 and loop through every character
  idx = 0
  while idx < string.length
  # 3. increment character by one value (.next)
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

puts encrypt(encrypt_string)

puts "Type a word for decrypting:"
decrypt_string = gets.chomp

def decrypt(string)
  # 1. Define an reference string of "abcdefghijklmnopqrstuvwxyz"
  ref_string = "abcdefghijklmnopqrstuvwxyz"
  # 3. Start at index 0 and loop through every character
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

puts decrypt(decrypt_string)

  # 4. Get character, get character index of character from reference string
  # 5. Subract 1 from returned reference string index value
  # 6. Set character in input string to str[0] = reference[reference value - 1]
  # 7. Move to next character in input string until 'nil' is reached. 

