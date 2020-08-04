# frozen_string_literal: true

class ProjectFormReflex < ApplicationReflex
  include PublicProjectParams

  before_reflex :set_project

  GITHUB_PREFIX = "https://github.com/"
  NPM_PREFIX = "https://www.npmjs.com/package/"

  def assign_github_name
    return unless @project.github_url.present?
    return unless @project.attr_valid?(:github_url)
    return if @project.github_name.present? && @project.github_url.include?(@project.github_name)
    name_parts = @project.github_url.delete_prefix(GITHUB_PREFIX).split("/")
    @project.github_name = [name_parts[0], name_parts[1]].join("/")
  end

  def assign_github_url
    return unless @project.attr_valid?(:github_name)
    return if @project.github_name.blank?
    return if @project.github_url.to_s.include?(@project.github_name)
    @project.github_url = "#{GITHUB_PREFIX}#{@project.github_name}"
  end

  def assign_npm_name
    return unless @project.npm_url.present?
    return unless @project.attr_valid?(:npm_url)
    return if @project.npm_name.present? && @project.npm_url.include?(@project.npm_name)
    @project.npm_name = @project.npm_url.delete_prefix(NPM_PREFIX)
  end

  def assign_npm_url
    return unless @project.attr_valid?(:npm_name)
    return if @project.npm_name.blank?
    return if @project.npm_url.to_s.include?(@project.npm_name)
    @project.npm_url = "#{NPM_PREFIX}#{@project.npm_name}"
  end

  private

  def set_project
    @project = Project.new(public_project_params).tap(&:validate)
  end
end
