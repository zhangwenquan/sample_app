def sign_in(user)
	visit signin_path
	fill_in "Email", with: user.name
	fill_in "Password", with: user.password
	click_button "Sign in"
	# Sign in when not use capybara as well
	cookies[:remember_token] = user.remember_token
end