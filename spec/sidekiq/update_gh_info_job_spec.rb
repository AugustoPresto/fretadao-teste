require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe UpdateGhInfoJob, type: :job do
  let(:job_instance) { UpdateGhInfoJob.new }
  let(:user) { FactoryBot.create(:user, github_url: "https://github.com/AugustoPresto") }

  context "Perform job" do
    it "Runs the job correctly" do
      expect(job_instance.perform(user.id)).to eq(true)
      assert_equal "default", described_class.queue
    end
  end
end
