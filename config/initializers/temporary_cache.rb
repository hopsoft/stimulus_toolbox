# frozen_string_literal: true

def Rails.temporary_cache
  @temporary_cache ||= if Rails.env.test?
    ActiveSupport::Cache::NullStore.new
  else
    ActiveSupport::Cache::MemoryStore.new(
      size: ENV.fetch("TEMPORARY_CACHE_MEGABYTES", 64).to_i.megabytes,
      expires_in: 1.hour
    )
  end
end
