namespace :manyusers do
  task create: :environment do
    num_users = 1000

    chunk = 20
    iterations = num_users / chunk

    iterations.times do |i|
      sql = 'INSERT INTO users (email, username, encrypted_password, last_name, first_name, created_at, updated_at, birthday, phone_number) VALUES '
      chunk.times do |i|
        sql = sql + '('
        sql = sql + "'#{rand_str}', "
        sql = sql + "'#{rand_str}', "
        sql = sql + "'#{rand_str}', "
        sql = sql + "'#{rand_str}', "
        sql = sql + "'#{rand_str}', "
        sql = sql + "'#{Time.now}', "
        sql = sql + "'#{Time.now}', "
        sql = sql + "'1900/01/01', "
        sql = sql + "'456-456-4567')"
        sql = sql + ', ' unless i == (chunk - 1)
      end
      sql = sql + ';'
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def rand_str
    (0...8).map { (65 + rand(26)).chr }.join
  end
end
