# frozen_string_literal: true

module PublicProjectParams
  extend ActiveSupport::Concern

  protected

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
