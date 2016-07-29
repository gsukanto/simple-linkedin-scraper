class Website < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, websites)
    redis_key = get_redis_key(user_id)
    websites.reverse_each do |website|
      $redis.lpush(redis_key, website)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_WEBSITE}#{user_id}"
  end
end
