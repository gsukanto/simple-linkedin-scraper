class Group < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, groups)
    redis_key = get_redis_key(user_id)
    groups.reverse_each do |group|
      $redis.lpush(redis_key, group)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_GROUP}#{user_id}"
  end
end
