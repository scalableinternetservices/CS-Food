namespace :manyorders do
  task create: :environment do
    user = User.last

    num_orders = 10000

    chunk = 100
    iterations = num_orders / chunk

    iterations.times do |i|
      sql = 'INSERT INTO orders (title, text, user_id, points, created_at, updated_at) VALUES '
      chunk.times do |i|
        sql = sql + '('
        sql = sql + "'#{rand_str}', "
        sql = sql + "'#{rand_str}', "
        sql = sql + "#{user.id}, "
        sql = sql + "#{rand(10)}, "
        sql = sql + "'#{Time.now}', "
        sql = sql + "'#{Time.now}')"
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
