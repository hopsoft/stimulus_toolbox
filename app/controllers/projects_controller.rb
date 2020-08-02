class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order(:name)
  end

  def new
    @project = Project.new(public_project_params)
    @project.validate
  end

  private

  def public_project_params
    return ActionController::Parameters.new unless params.has_key?(:project)
    params.require(:project).permit(
      :name,
      :url,
      :description,
      :github_name,
      :github_url,
      :npm_name,
      :npm_url
    )
  end
end
