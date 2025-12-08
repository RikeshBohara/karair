# Preview all emails at http://localhost:3000/rails/mailers/interview_mailer
class InterviewMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/interview_mailer/interview_email
  def interview_email
    InterviewMailer.interview_email
  end
end
