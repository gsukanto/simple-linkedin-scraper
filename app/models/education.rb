class Education < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, educations)
    redis_key = get_redis_key(user_id)
    educations.reverse_each do |education|
      $redis.lpush(redis_key, education)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_EDUCATION}#{user_id}"
  end
end
