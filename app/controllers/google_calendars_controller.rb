# frozen_string_literal: true

class GoogleCalendarsController < ApplicationController
  def index
  end

  def redirect_to_google_calendar_auth
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  private

    def client_options
      {
        client_id: Rails.application.credentials.google_calendar[:client_id],
        client_secret: Rails.application.credentials.google_calendar[:client_secret],
        authorization_uri: "https://accounts.google.com/o/oauth2/auth",
        token_credential_uri: "https://accounts.google.com/o/oauth2/token",
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        refresh_token: current_user.google_authentication.dig("refresh_token"),
        redirect_uri: google_authorization_url
      }
    end
end
