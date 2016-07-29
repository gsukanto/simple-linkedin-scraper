class Certification < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, certifications)
    redis_key = get_redis_key(user_id)
    certifications.reverse_each do |certification|
      $redis.lpush(redis_key, certification)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_CERTIFICATION}#{user_id}"
  end
end
