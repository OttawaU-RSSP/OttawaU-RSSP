lawyer = Lawyer.create!(name: "Example Lawyer", email: "example@example.com", password: "test", approved: true)

puts "Created lawyer #{lawyer.email} with password 'test'"
