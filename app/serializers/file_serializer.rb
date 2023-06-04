class FileSerializer < ActiveModel::Serializer
  attributes :id, :attachments_url

  def attachments_url
    object.attachments.map { |attachment| attachment.file.url }
  end
end
