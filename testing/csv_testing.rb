require 'google/apis/civicinfo_v2'
def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody','legislatorLowerBody']
    ).officials
    #
    # .officials.map(&:name).join(',')
    # legislators = legislators.officials
    # legislator_names = legislators.map(&:name)
    # legislator_names.join(',')
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end
legis = legislators_by_zipcode('33703')
# puts "#{legis.each_with_index{|item,index| puts "#{index}, #{item}"}}"
puts "#{legis[0].class}"
# binding.pry
puts "GOODBYE"