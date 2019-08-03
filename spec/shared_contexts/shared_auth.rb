shared_context 'authorized user', auth: true do
  before { sign_in(user) }
end
