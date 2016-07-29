class Organization < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, organizations)
    redis_key = get_redis_key(user_id)
    organizations.reverse_each do |organization|
      $redis.lpush(redis_key, organization)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_ORGANIZATION}#{user_id}"
  end
end
