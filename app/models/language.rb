class Language < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, languages)
    redis_key = get_redis_key(user_id)
    languages.reverse_each do |language|
      $redis.lpush(redis_key, language)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_LANGUAGE}#{user_id}"
  end
end
