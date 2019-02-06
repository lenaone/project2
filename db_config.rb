options = {
    adapter: 'postgresql',
    database: 'reviews_db'
}

ActiveRecord::Base.establish_connection(options)