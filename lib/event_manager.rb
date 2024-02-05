require 'csv'
puts 'Event Manager Initialized!'

#overwhelmed? take it slow, it s a lot
def clean_zipcode(zipcode)
  #third version
  zipcode = zipcode.to_s[0..4].rjust(5,'0')
  #second
  # zipcode = zipcode.to_s
  # zipcode = zipcode[0..4]
  # zipcode = zipcode.rjust(5,'0')
  #first
  # if zipcode.nil?
    # zipcode = '00000'
  # if zipcode.length >5
  #   zipcode = zipcode.slice[0..4]
  # elsif zipcode.length <5
  #   n = 5-zipcode.length
  #   zipcode = zipcode.rjust(5,'0')
  # else
  #   zipcode
  # end
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
) #CSV object (enumerable)
  #converting header into symbol will make our column names mor uniform and easier to remember

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])
  
  puts "#{name} #{zipcode}"
end