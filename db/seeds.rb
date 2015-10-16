lawyer = Lawyer.create!(name: "Example Lawyer", email: "example@example.com", password: "test", approved: true, extra: {
  approved: true,
  address: "1st Downing St.",
  telephone: "01189998819991197253",
  employer_name: "Her Majesty",
  employer_address: "Unknown",
  employment_type: "Court",
  practicing: true,
  year_of_call: "1900",
  law_society: "LSUC",
  areas_of_practice: ['Environment', 'Family'],
  experience_with_refugee_sponsorships: false,
  experience_with_refugee_sponsorships_clarification: '',
  insurance: 'Yes',
  can_accomodate_meetings: true,
  areas_of_interest: ['Providing ongoing assistance to sponsors through SSP matching'],
  comments: ''
})

puts "Created lawyer #{lawyer.email} with password 'test'"
