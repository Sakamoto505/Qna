# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: [:destroy]

  def destroy
    authorize @link

    @link.destroy
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end
end
