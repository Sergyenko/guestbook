# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mrdimi_session',
  :secret      => '392ab518079313b907df23905fd70aa41d8e3fa0e43f99d95e4ba04c1d6ef2876f35807b99646f9942cb9135db1f2ab7d209cbc0d6cf3c1a56e88fbebdcb39e1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
