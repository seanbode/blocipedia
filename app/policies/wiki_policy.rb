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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if current_user.role == 'admin'
        wikis = scope.all
      elsif current_user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == current_user || wiki.collaborators.include?(current_user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(current_user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
