# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :destroy? do
    let(:answer) { create(:answer) }

    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:link, linkable: answer))
    end

    it 'grants access if user is author of parent resource' do
      answer.update(author: user)

      expect(subject).to permit(user, create(:link, linkable: answer))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(user, create(:link))
    end
  end
end
