# frozen_string_literal: true

class ProjectSearchFormReflex < ApplicationReflex
  def search
    params[:query] = element.value.to_s.strip
    params[:page] = 1
    cable_ready[stream_name].dispatch_event(
      name: "stimulus-toolbox:set-location",
      detail: {path: controller.paginated_projects_path(page: 1)}
    )
    cable_ready.broadcast
  end
end
