class Visitor < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, visitors)
    redis_key = get_redis_key(user_id)
    visitors.reverse_each do |visitor|
      $redis.lpush(redis_key, visitor)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_VISITOR}#{user_id}"
  end
end
