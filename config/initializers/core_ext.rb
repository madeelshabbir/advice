# frozen_string_literal: true

CORE_EXT_FILES = Dir.glob(Rails.root.join('lib/core_exts/**/*.rb'))

CORE_EXT_FILES.each { |extension| require extension }
