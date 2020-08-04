# frozen_string_literal: true

class ProjectsController < ApplicationController
  include Pagy::Backend
  include PublicProjectParams

  def index
    projects = Project.approved.order(:name)
    @pagy, @projects = pagy(projects)
  end

  def new
    @project ||= Project.new(public_project_params).tap(&:validate)
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
end
