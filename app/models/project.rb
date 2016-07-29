class Project < ActiveRecord::Base
  # Change this model fuction to use Redis instead of RDB
  # See migration file

  def self.create(user_id, projects)
    redis_key = get_redis_key(user_id)
    projects.reverse_each do |project|
      $redis.lpush(redis_key, project)
    end
  end

  private
  def self.get_redis_key(user_id)
    return "#{CLASS_PROJECT}#{user_id}"
  end
end
