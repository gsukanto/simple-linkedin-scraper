class Company < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, companies)
    redis_key = get_redis_key(user_id)
    companies.reverse_each do |company|
      $redis.lpush(redis_key, company)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_COMPANY}#{user_id}"
  end
end
