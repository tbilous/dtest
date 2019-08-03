(1..10).to_a.each do |i|
  User.create(email: "user#{i}@lvh.me", password: 'foobar')
end
