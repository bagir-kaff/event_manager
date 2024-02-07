# event_manager.rb

Stuff i got while completing this (feb 6) :
- rjust method
- You can cut off the conditionals because some methods dont care and do nothing, and you can group them together
```ruby
#looking if the zipcode is 5 digit, if more then take the first five, if less add zero to the front until five, if empty then make it 00000

#not bad
if zipcode.nil?
 zipcode = '00000'
if zipcode.length >5
  zipcode = zipcode.slice[0..4]
elsif zipcode.length <5
  zipcode = zipcode.rjust(5,'0')
else
  zipcode
end
#better
zipcode = zipcode.to_s #turns nil into ''
zipcode = zipcode[0..4]
zipcode = zipcode.rjust(5,'0')
#best
zipcode = zipcode.to_s[0..4].rjust(5,'0')
```
- Still dont understand how API works (if got it will write something about it here)
  - where is it come from? let say i want to make an api, what to do first
  - 
- Strings can be defined with %{} example:
```ruby
new_string = 'my
name
is 
Walter White'
#that is the same as this
new_string = %{my
name
is
Walter White}
```
- solution for these problems
  - Using FIRST_NAME and LEGISLATORS to find and replace might cause us problems if later somehow this text appears in any of our templates
  ```ruby
    personal_letter = template_letter.gsub('FIRST_NAME',name)
    personal_letter = personal_letter.gsub('LEGISLATORS',legislators)

    # we can use Ruby's ERB (a template language, using ERB actual ruby code can be added to any plain text for the purpose of generating document detail and/or flow control)

  ```
  go here:
  https://www.theodinproject.com/lessons/ruby-event-manager#iteration-4-form-letters

- There is a shorthand of map
```ruby
#make an array
    legislators_name = legislators.map do |legislator|
      legislator.name
    end 

    legislators_name = legislators.map(&:name)
    #need explaination
```
