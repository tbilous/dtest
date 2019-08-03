5.times.each do
  DonationType.create(name: Faker::Name.first_name)
end
