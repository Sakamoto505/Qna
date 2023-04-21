# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :update? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:answer))
    end

    it 'grants access if user is author' do
      expect(subject).to permit(user, create(:answer, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(user, create(:answer))
    end
  end

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:answer))
    end
    it 'grants access if user is author' do
      expect(subject).to permit(user, create(:answer, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(user, create(:answer))
    end
  end

  permissions :set_best? do
    let(:question) { create(:question, author: user) }
    it 'grants access if user is author of question' do
      expect(subject).to permit(user, create(:answer, question: question, author: user))
    end

    it 'denies access if user is not author of question' do
      expect(subject).not_to permit(user, create(:answer))
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(nil, create(:answer))
    end
  end
end
