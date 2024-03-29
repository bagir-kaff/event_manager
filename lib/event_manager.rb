require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
#overwhelmed? take it slow, it s a lot

def clean_zipcode(zipcode)
  zipcode = zipcode.to_s[0..4].rjust(5,'0')
end

def legislators_by_zipcode(zipcode)

  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody','legislatorLowerBody']
    ).officials # returns original legislators
    # puts legislators
  rescue
    'you can find you representatives by visiting www.commoncause.org/take-action/find-elected-official'
  end
end

def generate_letter(id,template)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts template
  end
end

def clean_phone_number(number)
  number = number.tr('- ','')
  if number.length ==10
    number
  elsif number.length == 11 && number[0]==1
    number[1..10]
  else 
    'bad_format'
  end
end
template_letter = File.read ('form_letter.html')
erb_template = ERB.new template_letter
puts 'Event Manager Initialized!'

def peak_hours(contents)
  list = contents.reduce({}) do |data,row|
    registration_hour = Time.strptime(row[:regdate],'%Y/%d/%m %k:%M').hour
    data[registration_hour] = data[registration_hour].to_i + 1
    data
  end
  list.sort_by {|_key, value| value}.reverse.to_h
end

def peak_days(contents)
  list = contents.reduce({}) do |data,row|
    registration_day = Date.strptime(row[:regdate],'%Y/%d/%m %k:%M').strftime("%A")
    data[registration_day] = data[registration_day].to_i + 1
    data
  end
  list.sort_by {|_key, value| value}.reverse.to_h
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
) #CSV object (enumerable)
  #converting header into symbol will make our column names mor uniform and easier to remember

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
 
  generate_letter(id,form_letter)
end