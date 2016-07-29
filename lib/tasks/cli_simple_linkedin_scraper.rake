namespace :scraper do
  require 'linkedin-scraper'

  desc "linkedin scraper. Usage = bundle exec rake scraper:linkedin URL=\"https://target_url/\""
  task linkedin: :environment do
    url = validate_url(ENV['URL'])
    profile = Linkedin::Profile.new(url, {company_details: true})

    print_profile(profile)

    # TODO: Also need to check if the data wasn't updated
    save_profile(profile) if !get_user_id_by_url(profile.linkedin_url)
  end

  private
  def validate_url(url)
    # TODO: Need proper validation (single url, valid url, etc)
    return url
  end

  def get_user_id_by_url(url)
    return User.find_by(linkedin_url: url).try(:id)
  end

  def save_profile(profile)
    set_user(profile)
    user_id = get_user_id_by_url(profile.linkedin_url)

    # TODO: Need proper error handling
    return if !user_id

    set_certifications(user_id, profile.certifications)
    set_companies(user_id, [profile.current_companies, past_companies])
    set_educations(user_id, profile.education)
    set_groups(user_id, profile.groups)
    set_languages(user_id, profile.languages)
    set_organizations(user_id, profile.organizations)
    set_projects(user_id, profile.skills)
    set_visitors(user_id, profile.recommended_visitors)
    set_websites(user_id, profile.websites)
  end

  def print_profile(profile)
    # TODO: Use proper getter
    puts SPLITTER, "Basic Informations", SPLITTER
    puts "Linkedin URL: " + profile.linkedin_url.to_s
    puts "First Name: "   + profile.first_name.to_s
    puts "Last Name: "    + profile.last_name.to_s
    puts "Title: "        + profile.title.to_s
    puts "Summary: "      + profile.summary.to_s
    puts "Location: "     + profile.location.to_s
    puts "Country: "      + profile.country.to_s
    puts "Industry: "     + profile.industry.to_s
    puts "Picture: "      + profile.picture.to_s

    puts SPLITTER, "Certifications:",        profile.certifications
    puts SPLITTER, "Companies:",             profile.current_companies, profile.past_companies
    puts SPLITTER, "Educations:",            profile.education
    puts SPLITTER, "Groups:",                profile.groups
    puts SPLITTER, "Languages:",             profile.languages
    puts SPLITTER, "Organizations:",         profile.organizations
    puts SPLITTER, "Project:",               profile.projects
    puts SPLITTER, "Skills:",                profile.skills
    puts SPLITTER, "Recommended Visitors:",  profile.recommended_visitors
    puts SPLITTER, "Websites:",              profile.websites
    puts SPLITTER, SPLITTER
  end

  def set_user(profile)
    User.create(
      linkedin_url: profile.linkedin_url,
      first_name: profile.first_name,
      last_name: profile.last_name, 
      title: profile.title,
      summary: profile.summary,
      location: profile.location,
      country: profile.country,
      industry: profile.industry,
      picture: profile.picture
    )
  end

  def set_certifications(user_id, certifications)
    Certification.create(user_id, certifications)
  end

  def set_companies(user_id, companies)
    Company.create(user_id, companies)
  end

  def set_educations(user_id, educations)
    Education.create(user_id, educations)
  end

  def set_groups(user_id, groups)
    Group.create(user_id, groups)
  end

  def set_languages(user_id, languages)
    Language.create(user_id, languages)
  end

  def set_number_of_connections(user_id, number_of_connections)
    $redis.lpush("#{REDIS_USER_CONNECTIONS_KEY}#{user_id}", number_of_connections)
  end

  def set_organizations(user_id, organizations)
    Organization.create(user_id, organizations)
  end

  def set_projects(user_id, projects)
    Project.create(user_id, projects)
  end

  def set_skills(user_id, skills)
    Skill.create(user_id, skills)
  end

  def set_visitors(user_id, visitors)
    Visitor.create(user_id, visitors)
  end

  def set_websites(user_id, websites)
    Website.create(user_id, websites)
  end
end