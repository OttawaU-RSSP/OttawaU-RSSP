lawyer = Lawyer.create!(name: "Example Lawyer", email: "example_lawyer@example.com", password: "test", approved: true, extra: {
  approved: true,
  address1: "1st Downing St.",
  city: "Ottawa",
  province: "Ontario",
  telephone: "01189998819991197253",
  employer_name: "Her Majesty",
  employer_address: "Unknown",
  employment_type: "Court",
  practicing: true,
  year_of_call: "1900",
  law_society_number: "LSUC-1234",
  areas_of_practice: ['Environment', 'Family'],
  language_of_practice: "English",
  experience_with_refugee_sponsorships: false,
  experience_with_refugee_sponsorships_clarification: '',
  insurance: 'Yes',
  can_accomodate_meetings: true,
  areas_of_interest: ['Providing ongoing assistance to sponsors through SSP matching'],
  comments: '',
  private_notes: 'Private notes'
})
puts "Created lawyer #{lawyer.email} with password 'test'"

student = Student.create!(name: "Example Student", email: "example_student@example.com", password: "test", approved: true, extra: {
  approved: true,
  telephone: '0016138289375',
  city: 'Ottawa',
  province: 'Ontario',
  university: 'Carleton',
  language: 'English',
  course: 'CS1037',
  campus_group: 'Carleton students',
  private_notes: 'Private notes'
})
puts "Created student #{student.email} with password 'test'"

admin = Admin.create!(name: "Example Admin", email: "example_admin@example.com", password: "test", approved: true)
puts "Created admin #{admin.email} with password 'test'"

sponsor_group = SponsorGroup.create!(
  name: 'Example Sponsor Group',
  phone: '123456678',
  email: 'example_sponsor_group@example.com',
  address_line_1: 'address 1',
  address_line_2: 'address 2',
  city: 'City',
  postal_code: 'K9J9J8',
  citizenship_status: 'Canadian Citizen',
  connected_to_refugee: true,
  refugee_connection_type: 'Family',
  refugee_outside_country_of_origin: true,
  group_size: 5,
  sah_connection: false,
  interpreter_needed: false,
  sufficient_resources: true,
  criminal_record: false,
  province: 'Ontario',
  public_notes: 'Public notes',
  private_notes: 'Private notes',
  proper_group_size: true,
  refugee_name: 'Refugee name',
  refugee_nationality: 'Nationality',
  refugee_current_location: 'Mars',
  connect_refugee_family_in_canada: false,
  add_to_refugee_assistance_list: true,
  public_meeting_notes: 'Public meeting notes',
  private_meeting_notes: 'Private meeting notes'
)
application = sponsor_group.create_application
puts "Created sponsor group #{sponsor_group.email} with application #{application.id}"
