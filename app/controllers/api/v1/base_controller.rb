class Api::V1::BaseController < ApplicationController

  before_action :doorkeeper_authorize!

  private

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_user
    if doorkeeper_token
      return current_resource_owner
    end
    warden.authenticate(:scope => :user)
  end
end