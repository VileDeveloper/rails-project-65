# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def update?
    record_author?
  end

  def show?
    @record.published? || record_author? || @user&.admin?
  end

  def archive?
    record_author?
  end

  def to_moderate?
    record_author?
  end

  private

  def record_author?
    @record.user_id == @user&.id
  end
end
