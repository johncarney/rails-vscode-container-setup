# frozen_string_literal: true

require "pathname"

module FileFixtureHelper
  def file_fixture(file_path)
    Pathname(__dir__) / "../fixtures/files" / Pathname(file_path)
  end
end
