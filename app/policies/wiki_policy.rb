class WikiPolicy < ApplicationPolicy
  attr_reader :user, :record

  def new?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def edit?
    user.present? && (record.user == user || user.admin?)
  end

  def update?
    user.present? && (record.user == user || user.admin?)
  end

end
