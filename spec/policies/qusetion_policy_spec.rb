# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:question))
    end
    it 'grants access if user is author' do
      expect(subject).to permit(user, create(:question, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(user, create(:question))
    end
  end

  permissions :new? do
    it 'grants access if user is exists' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(nil)
    end
  end

  permissions :create? do
    it 'grants access if user is exists' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(nil)
    end
  end

  permissions :comment? do
    it 'grants access if user is exists' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(nil)
    end
  end

  permissions :user? do
    it 'grants access if user is exists' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(nil)
    end
  end
end
