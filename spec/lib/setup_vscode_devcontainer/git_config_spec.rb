# frozen_string_literal: true

require "securerandom"
require "tmpdir"

require "setup_vscode_devcontainer/git_config"

RSpec.describe SetupVSCodeDevcontainer::GitConfig do # rubocop:disable RSpec/FilePath
  subject(:config) { described_class.new(location: config_location) }

  describe "#get" do
    context "with a custom config file" do
      let(:config_location) { file_fixture("gitconfig") }

      it "reads the config from the file" do
        # NB: This is uncomfortably close to testing implementation details,
        #     but I'm not sure how to test this without doing so.
        allow(Open3).to receive(:capture3).and_call_original
        config.get("some.key")
        expect(Open3).to have_received(:capture3).with("git", "config", "--file", config_location.to_s, "some.key")
      end

      context "for a key that has a value" do
        subject(:value) { config.get("user.name") }

        it "returns the value" do
          expect(value).to eq "Ada Lovelace"
        end
      end

      context "for a key that does not exist" do
        subject(:value) { config.get("not.found") }

        it { is_expected.to be_nil }
      end

      context "for a key that is blank" do
        subject(:value) { config.get("blank.value") }

        it { is_expected.to be_nil }
      end
    end

    %i[local global system worktree].each do |location|
      context "with #{location} config" do
        let(:config_location) { location }

        it "reads the #{location} config" do
          # NB: This is uncomfortably close to testing implementation details,
          #     but I'm not sure how to test this without doing so.
          allow(Open3).to receive(:capture3).and_call_original
          config.get("some.key")
          expect(Open3).to have_received(:capture3).with("git", "config", "--#{location}", "some.key")
        end
      end
    end

    context "when the location is not specified" do
      let(:config_location) { nil }

      it "reads from the default config" do
        # NB: This is uncomfortably close to testing implementation details,
        #     but I'm not sure how to test this without doing so.
        allow(Open3).to receive(:capture3).and_call_original
        config.get("some.key")
        expect(Open3).to have_received(:capture3).with("git", "config", "some.key")
      end
    end
  end

  describe "#set" do
    context "with a custom config file" do
      let(:config_location) { Pathname(Dir.tmpdir) / "gitconfig-#{SecureRandom.uuid}" }

      around do |example|
        example.run
      ensure
        config_location.delete if config_location.exist?
      end

      it "writes to the given file" do
        # NB: This is uncomfortably close to testing implementation details,
        #     but I'm not sure how to test this without doing so.
        allow(Open3).to receive(:capture3).and_call_original
        allow(Open3).to receive(:capture3).with("git", "config", any_args)
        config.set("some.key", "some value")
        expect(Open3).to have_received(:capture3).with(
          "git", "config", "--file", config_location.to_s, "some.key", "some value"
        )
      end

      it "writes the value to the file" do
        config.set("some.key", "some value")
        expect(config.get("some.key")).to eq "some value"
      end
    end

    %i[local global system worktree].each do |location|
      context "writes to #{location} config" do
        let(:config_location) { location }

        it "reads the #{location} config" do
          # NB: This is uncomfortably close to testing implementation details,
          #     but I'm not sure how to test this without doing so.
          allow(Open3).to receive(:capture3).and_call_original
          allow(Open3).to receive(:capture3).with("git", "config", any_args) # We don't want to pollute the real config
          config.set("some.key", "some value")
          expect(Open3).to have_received(:capture3).with("git", "config", "--#{location}", "some.key", "some value")
        end
      end
    end

    context "when the location is not specified" do
      let(:config_location) { nil }

      it "writes to the default config" do
        # NB: This is uncomfortably close to testing implementation details,
        #     but I'm not sure how to test this without doing so.
        allow(Open3).to receive(:capture3).and_call_original
        allow(Open3).to receive(:capture3).with("git", "config", any_args) # We don't want to pollute the real config
        config.set("some.key", "some value")
        expect(Open3).to have_received(:capture3).with("git", "config", "some.key", "some value")
      end
    end
  end
end
