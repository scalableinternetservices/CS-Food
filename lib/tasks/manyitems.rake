namespace :manyitems do
  task create: :environment do
    num_items = 10000

    chunk = 100
    iterations = num_items / chunk

    iterations.times do |i|
      sql = 'INSERT INTO items (name, created_at, updated_at) VALUES '
      chunk.times do |i|
        sql = sql + '('
        sql = sql + "'#{rand_str}', "
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
