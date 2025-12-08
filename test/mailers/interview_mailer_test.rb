require "test_helper"

class InterviewMailerTest < ActionMailer::TestCase
  test "interview_email" do
    mail = InterviewMailer.interview_email
    assert_equal "Interview email", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
