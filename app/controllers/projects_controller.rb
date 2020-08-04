# frozen_string_literal: true

class ProjectsController < ApplicationController
  include Pagy::Backend
  include PublicProjectParams

  def index
    full_text_search_results = Project.full_text_search_relation(params[:query].to_s)
    @pagy, @full_text_search_results = pagy(full_text_search_results)
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
