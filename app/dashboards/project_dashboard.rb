require "administrate/base_dashboard"

class ProjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    full_text_search: Field::HasOne,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    github_sychronized_at: Field::DateTime,
    npm_sychronized_at: Field::DateTime,
    human_name: Field::String,
    github_name: Field::String,
    npm_name: Field::String,
    description: Field::Text,
    url: Field::String,
    github_url: Field::String,
    npm_url: Field::String,
    license_name: Field::String,
    license_url: Field::String,
    tags: Field::Text.with_options(searchable: false),
    github_data: Field::String.with_options(searchable: false),
    npm_data: Field::String.with_options(searchable: false)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    human_name
    github_name
    npm_name
    created_at
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    full_text_search
    id
    created_at
    updated_at
    github_sychronized_at
    npm_sychronized_at
    human_name
    github_name
    npm_name
    description
    url
    github_url
    npm_url
    license_name
    license_url
    tags
    github_data
    npm_data
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    human_name
    github_name
    npm_name
    description
    url
    github_url
    npm_url
    tags
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how projects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(project)
  #   "Project ##{project.id}"
  # end
end
