# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment, only: [:destroy]

  def destroy
    if @attachment.record.author == current_user
      @attachment.purge
      if @attachment.record.is_a?(Answer)
        redirect_to @attachment.record.question, notice: 'File deleted successfully'
      else
        redirect_to @attachment.record, notice: 'File deleted successfully'
      end
    else
      redirect_to @attachment.record, alert: 'You cannot delete this file'
    end
  end

  private

  def set_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end
