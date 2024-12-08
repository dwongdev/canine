class Projects::ValidateGithubRepository
  extend LightService::Action

  expects :project
  promises :project

  executed do |context|
    client = Octokit::Client.new(access_token: context.project.github_access_token)
    unless client.repository?(context.project.repository_url)
      context.project.errors.add(:repository_url, 'does not exist')
      context.fail_and_return!('Repository does not exist')
    end
  rescue Octokit::Forbidden => e
    context.project.errors.add(:repository_url, 'cannot be accessed')
    context.fail_and_return!('Repository cannot be accessed, try logging out and in again')
  end
end
