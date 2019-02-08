options = {
    adapter: 'postgresql',
    database: 'reviews_db'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)

