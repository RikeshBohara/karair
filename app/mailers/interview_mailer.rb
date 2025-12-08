class InterviewMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.interview_mailer.interview_email.subject
  #
  def interview_email(job, applicant, recruiter)
    Rails.logger.debug "InterviewMailer: job=#{job.inspect}, applicant=#{applicant.inspect}, recruiter=#{recruiter.inspect}"
    @job = job
    @applicant = applicant
    @recruiter = recruiter

    mail to: @applicant.email, subject: "Interview Invitation for #{@job.title} from #{@recruiter.profile.company_name}"
  end
end
