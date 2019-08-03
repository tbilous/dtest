counter = (5..8).to_a

(10.days.ago.to_date..Date.current).to_a.each do |e|
  User.pluck(:id).each do |i|
    counter.sample.times.each do |j|
      Donation.create(user_id: i, donation_type_id: j, date: e)
    end
  end
end
