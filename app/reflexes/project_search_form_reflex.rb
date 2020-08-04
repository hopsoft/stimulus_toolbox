# frozen_string_literal: true

class ProjectSearchFormReflex < ApplicationReflex
  def search
    params[:query] = element.value.to_s.strip
    params[:page] = 1
  end
end
