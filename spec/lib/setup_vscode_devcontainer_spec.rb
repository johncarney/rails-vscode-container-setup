# frozen_string_literal: true

RSpec.describe SetupVSCodeDevcontainer do # rubocop:todo RSpec/FilePath
  it "has a version number" do
    expect(SetupVSCodeDevcontainer::VERSION).not_to be_nil
  end

  it "does something useful" do
    expect(false).to eq(true) # rubocop:todo RSpec/ExpectActual,RSpec/BeEq
  end
end
