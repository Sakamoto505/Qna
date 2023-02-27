# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:author) { create(:user) }
  let!(:question) { create(:question, :question_with_file, author: author) }
  let(:attachment_id) { question.files.attachments.first.id }

  describe 'DELETE #destroy' do
    context 'when the user is the author of the record' do
      before { sign_in author }

      it 'deletes the attachment' do
        expect { delete :destroy, params: { id: attachment_id } }.to change(question.files, :count).by(-1)

        expect(response).to redirect_to question
        expect(flash[:notice]).to eq('File deleted successfully')
      end
    end

    context 'when the user is not the author of the record' do
      before { sign_in user }

      it 'does not delete the attachment' do
        expect do
          delete :destroy, params: { id: attachment_id }
        end.not_to change(question.files.attachments, :count)

        expect(response).to redirect_to question
        expect(flash[:alert]).to eq('You cannot delete this file')
      end
    end

    context 'when the user is not authenticated' do
      it 'does not delete the attachment' do
        expect do
          delete :destroy, params: { id: attachment_id }
        end.not_to change(question.files.attachments, :count)

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'Answer files delete' do
    let(:user) { create(:user) }
    let(:author) { create(:user) }

    before { sign_in author }

    subject { delete :destroy, params: { id: answer.files.first, format: :js } }

    context 'user is answer owner' do
      let!(:answer) { create(:answer, :answer_with_file, author: author) }

      it { expect { subject }.to change(ActiveStorage::Attachment, :count).by(-1) }
    end
  end
end
