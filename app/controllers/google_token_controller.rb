class GoogleTokenController < ApplicationController

  def token
    scope = 'https://www.googleapis.com/auth/androidpublisher'

    render json: application_json.merge(google_authorizer(scope).fetch_access_token!),
           status: :OK
  end

  def drive_files
    drive = ::Google::Apis::DriveV3::DriveService.new

    scope = 'https://www.googleapis.com/auth/drive'

    authorizer = google_authorizer(scope)
    drive.authorization = authorizer

    list_files = drive.list_files
    render json: application_json.merge(list_files), status: :OK
  end

  private

  def application_json
    {
      RailsVersion: Rails.version,
      RubyVersion: RUBY_VERSION
  }
  end

  def google_authorizer(scope)
    Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open("#{Rails.root}/google-oauth.json"),
      scope: scope
    )
  end
end
