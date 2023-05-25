require 'rails_helper'

RSpec.describe NotificationJobAnswersJob, type: :job do
  let(:service) { double('AnswerNotify') }
  let(:answer) { create(:answer) }

  before do
    allow(AnswerNotify).to receive(:new).and_return(service)
  end

  it 'calls AnswerNotify#send_notify' do
    expect(service).to receive(:send_notify)

    NotificationJobAnswersJob.perform_now(answer)
  end
end
