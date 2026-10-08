# config/initializers/version.rb

APP_VERSION = begin
  git_version = `git describe --tags --always 2>/dev/null`.strip
  if git_version.present?
    git_version
  else
    commits = `git rev-list --count HEAD 2>/dev/null`.strip
    commits.present? ? "0.0.0-#{commits}" : "0.0.0"
  end
rescue StandardError
  "0.0.0"
end

APP_LAST_UPDATED = begin
  git_date = `git log -1 --format=%cd --date=short 2>/dev/null`.strip
  if git_date.present?
    Date.parse(git_date).strftime("%d-%m-%Y")
  else
    Time.now.strftime("%d-%m-%Y")
  end
rescue StandardError
  Time.now.strftime("%d-%m-%Y")
end
