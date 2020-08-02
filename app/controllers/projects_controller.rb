class ProjectsController < ApplicationController
  include Pagy::Backend

  def index
    projects = Project.approved.order(:name)
    @pagy, @projects = pagy(projects)
  end

  def new
    @project = Project.new(public_project_params)
    @project.validate
  end

  def create
    @project = Project.new(public_project_params)
    if @project.save
      flash[:success] = "Your project was submitted successfully."
    else
      flash[:error] = "An error occurred when saving your project! Please try again."
    end
    redirect_to new_project_path
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
