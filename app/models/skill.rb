class Skill < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, skills)
    redis_key = get_redis_key(user_id)
    skills.reverse_each do |skill|
      $redis.lpush(redis_key, skill)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_SKILL}#{user_id}"
  end
end
