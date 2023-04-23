# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :gon_user, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: exception.message
      end
      format.json do
        render json: { error: exception.message }, status: 422
      end
      format.js do
        render json: { error: exception.message }, status: 422
      end
    end
  end

  private

  def gon_user
    gon.current_user_id = current_user.id if current_user
  end
end
