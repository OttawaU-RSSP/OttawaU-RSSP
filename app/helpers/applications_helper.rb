module ApplicationsHelper
  def intake_heading
    'Initial application submitted'
  end

  def intake_body
    'This application is pending basic SSP review. '
  end

  def intake_next_step(application)
    link_to "Approve", approve_intake_form_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def pending_follow_up_heading
    'Initial application accepted'
  end

  def pending_follow_up_body
    'This application has passed basic SSP review and is ready for an Intake Discussion.
    If you are matched to this sponsorship group for the Intake Discussion, please get in touch with them to set up an initial meeting.
    If this will occur at a clinic, please make sure they have all of the information about the date/time of the clinic. '
  end

  def pending_follow_up_next_step(application)
    link_to "Mark intake discussion as complete", mark_intake_discussion_complete_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def followed_up_heading
    'Intake discussion complete'
  end

  def followed_up_body
    'This application has been confirmed as eligible through an Intake Discussion and is ready for ongoing support. The model for this differs by location.
          If this requires a match to a different SSP Pro Bono Lawyer, please let the local coordinator know that the group is ready for their ongoing support lawyer to be matched.
          If you are the ongoing support lawyer, please proceed with supporting the application. No further matching action is needed.
          If ongoing support will happen at clinics, please ensure that the sponsorship group knows the dates/times of the clinics that are relevant to them.'
  end

  def followed_up_next_step(application)
    link_to "Approve intake discussion", approve_follow_up_call_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def pending_lawyer_match_heading
    'Pending lawyer match'
  end

  def pending_lawyer_match_body
    "This application is still valid after the intake discussion. Waiting to be matched with a pro bono lawyer"
  end

  def pending_lawyer_match_next_step(application)
    link_to "Mark lawyer as matched", mark_lawyer_matched_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def in_progress_heading
    'Lawyer matched'
  end

  def in_progress_body
    "This application is in progress and you are the SSP Pro Bono Lawyer or law student supporting the sponsorship group.
          Don't forget that the SSP has many support resources available on our website at www.refugessp.ca.
          When the application is complete in draft form, please indicate this using the relevant button and move on to your review."
  end

  def in_progress_next_step(application)
    link_to "Mark as completed", mark_completed_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def completed_heading
    'Application complete'
  end

  def completed_body
    'This application is complete in draft form and your review should be in process.
          If there are corrections or additions needed, please let the sponsorship group know.
          Once your review is complete and the file is ready for expert review, please indicate this using the relevant button and an
          SSP team member will help you coordinate the expert review. '
          # <a target="blank" href="http://refugeessp.ca/lawyer-resources/resource-application-review/">View review tips</a> (need to be logged in to your pro-bono lawyer login)
  end

  def completed_next_step(application)
    link_to "Mark review as passed", mark_lawyer_review_passed_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def lawyer_reviewed_heading
    'Lawyer review complete'
  end

  def lawyer_reviewed_body
    'Your review of this file is complete. A member of the SSP team will be in touch to coordinate expert review.
     Once you hear back from the expert,  please indicate this using the relevant button.'
    #  <a target="blank" href="http://refugeessp.ca/lawyer-resources/resource-application-review/">View review tips</a> (need to be logged in to your pro-bono lawyer login)
  end

  def lawyer_reviewed_next_step(application)
    link_to "Mark review as passed", mark_expert_review_passed_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def expert_reviewed_heading
    'Expert review complete'
  end

  def expert_reviewed_body
    'The expert file review for this application is complete.
     Please connect with the sponsorship group to give them final information about submitting their file. '
  end

  def expert_reviewed_next_step(application)
    link_to "Mark as submitted", mark_submitted_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def submitted_heading
    'Application submitted to GoC'
  end

  def submitted_body
    'This application has been submitted to the Government of Canada and is pending a response.
          If you hear about the outcome of this application and it is positive, please use the relevant button to indicate this.
          If it is rejected, please let us know and we will help advise you about next steps. '
  end

  def submitted_next_step(application)
    link_to "Mark as accepted", mark_accepted_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def accepted_heading
    'Application accepted by GoC'
  end

  def accepted_body
    "Congratulations! We understand that this sponsorship application has been accepted and the refugees will be coming to Canada soon.
          Don't forget to refer your clients to the organizations in your area who can help with the settlement process (beyond SSP scope).
          The impact that your assistance as an SSP Pro Bono Lawyer has made cannot be understated.
          Thank you for giving your time and skill to this sponsorship group through the SSP.
          The SSP would love to hear about your experience as an SSP Pro Bono Lawyer and any other news that you have to share.
          We would also love to facilitate another match. Please don't hesitate to be in touch with us at refugeessp@uottawa.ca."
  end

  def accepted_next_step(application)
  end
end
