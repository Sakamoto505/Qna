class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present? && !user.subscriptions.where(question: record.question).exists?
  end


  def destroy?
    user.present? && user.subscriptions.where(question: record.question).exists?
  end
end
