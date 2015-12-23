module ApplicationsHelper
  def intake_heading
    'Initial application submitted'
  end

  def intake_body
    if current_user.sponsor?
      'Thank you for submitting your application to work with an SSP Pro Bono Lawyer. A member of the SSP team will be reviewing your application shortly.'
    else
      'This application is pending basic SSP review. '
    end
  end

  def intake_next_step(application)
    return if current_user.sponsor?
    link_to "Approve", approve_intake_form_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def pending_follow_up_heading
    'Initial application accepted'
  end

  def pending_follow_up_body
    if current_user.sponsor?
      'Your application has been reviewed and a member of the SSP Team or a Pro Bono Lawyer will be in touch with you shortly to set up an Intake Discussion to learn more about your group.
      This may happen as part of a clinic or as a one-on-one discussion.'
    else
      'This application has passed basic SSP review and is ready for an Intake Discussion.
      If you are matched to this sponsorship group for the Intake Discussion, please get in touch with them to set up an initial meeting.
      If this will occur at a clinic, please make sure they have all of the information about the date/time of the clinic. '
    end
  end

  def pending_follow_up_next_step(application)
    return if current_user.sponsor?
    link_to "Mark intake discussion as complete", mark_intake_discussion_complete_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def followed_up_heading
    'Intake discussion complete'
  end

  def followed_up_body
    if current_user.sponsor?

    else
      'This application has been confirmed as eligible through an Intake Discussion and is ready for ongoing support. The model for this differs by location.
       If this requires a match to a different SSP Pro Bono Lawyer, please let the local coordinator know that the group is ready for their ongoing support lawyer to be matched.
       If you are the ongoing support lawyer, please proceed with supporting the application. No further matching action is needed.
       If ongoing support will happen at clinics, please ensure that the sponsorship group knows the dates/times of the clinics that are relevant to them.'
     end
  end

  def followed_up_next_step(application)
    return if current_user.sponsor?
    link_to "Approve intake discussion", approve_intake_discussion_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def pending_lawyer_match_heading
    'Pending lawyer match'
  end

  def pending_lawyer_match_body
    if current_user.sponsor?
      'Thank you for taking part in your Intake Discussion!
       We are happy to confirm that you will soon be matched with an SSP Pro Bono Lawyer for ongoing support.
       If you are in a location where SSP Pro Bono Lawyers provide support through clinics, your local coordination team will let you know where you can find information about clinic times & locations.'
    else
      "This application is still valid after the intake discussion. Waiting to be matched with a pro bono lawyer"
    end
  end

  def pending_lawyer_match_next_step(application)
    return if current_user.sponsor?
    link_to "Mark lawyer as matched", mark_lawyer_matched_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def in_progress_heading
    'Lawyer matched'
  end

  def in_progress_body
    if current_user.sponsor?
      'Thank you for completing your sponsorship application with the help of an SSP Pro Bono Lawyer.
       If your lawyer needs to share notes or other information with you, it will appear here or will be sent to you by email.'
    else
      "This application is in progress and you are the SSP Pro Bono Lawyer or law student supporting the sponsorship group.
       Don't forget that the SSP has many support resources available on our website at www.refugessp.ca.
       When the application is complete in draft form, please indicate this using the relevant button and move on to your review."
     end
  end

  def in_progress_next_step(application)
    return if current_user.sponsor?
    link_to "Mark as completed", mark_completed_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def completed_heading
    'Application complete'
  end

  def completed_body
    if current_user.sponsor?
      'Congratulations on completing a full draft of your sponsorship application!
       Your SSP Pro Bono Lawyer is in the process of reviewing the application and will follow up with you if changes or additions are needed at this time. '
    else
      'This application is complete in draft form and your review should be in process.
       If there are corrections or additions needed, please let the sponsorship group know.
       Once your review is complete and the file is ready for expert review, please indicate this using the relevant button and an
       SSP team member will help you coordinate the expert review. '
       # <a target="blank" href="http://refugeessp.ca/lawyer-resources/resource-application-review/">View review tips</a> (need to be logged in to your pro-bono lawyer login)
    end
  end

  def completed_next_step(application)
    return if current_user.sponsor?
    link_to "Mark review as passed", mark_lawyer_review_passed_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def lawyer_reviewed_heading
    'Lawyer review complete'
  end

  def lawyer_reviewed_body
    if current_user.sponsor?
      'Congratulations on completing a full draft of your sponsorship application!
       Your application has now completed review by your SSP Pro Bono Lawyer and is in the process of being reviewed by one of our SSP Sponsorship Experts.
       Your lawyer will follow up with you if changes or additions are needed. '
    else
      'Your review of this file is complete. A member of the SSP team will be in touch to coordinate expert review.
       Once you hear back from the expert,  please indicate this using the relevant button.'
      #  <a target="blank" href="http://refugeessp.ca/lawyer-resources/resource-application-review/">View review tips</a> (need to be logged in to your pro-bono lawyer login)
    end
  end

  def lawyer_reviewed_next_step(application)
    return if current_user.sponsor?
    link_to "Mark review as passed", mark_expert_review_passed_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def expert_reviewed_heading
    'Expert review complete'
  end

  def expert_reviewed_body
    if current_user.sponsor?
      'Congratulations! Your sponsorship application is complete and ready for submission.
       Your SSP Pro Bono Lawyer can provide any support that you need with this process. '
    else
      'The expert file review for this application is complete.
       Please connect with the sponsorship group to give them final information about submitting their file.'
    end
  end

  def expert_reviewed_next_step(application)
    return if current_user.sponsor?
    link_to "Mark as submitted", mark_submitted_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def submitted_heading
    'Application submitted to GoC'
  end

  def submitted_body
    if current_user.sponsor?
      "Congratulations! We understand that your sponsorship application has been submitted to the Government of Canada.
      Don't forget to let your SSP Pro Bono Lawyer know when you hear from Citizenship and Immigration Canada."
    else
      'This application has been submitted to the Government of Canada and is pending a response.
       If you hear about the outcome of this application and it is positive, please use the relevant button to indicate this.
       If it is rejected, please let us know and we will help advise you about next steps. '
    end
  end

  def submitted_next_step(application)
    return if current_user.sponsor?
    link_to "Mark as accepted", mark_accepted_legal_internal_application_path(application), method: :put, class: "btn btn-success"
  end

  def accepted_heading
    'Application accepted by GoC'
  end

  def accepted_body
    if current_user.sponsor?
      "Congratulations! We understand that your sponsorship application has been accepted and the refugees that you are sponsoring will be coming to Canada soon.
       Don't forget that there are organizations in your area who can help with the settlement process.
       The SSP would love to hear about your sponsorship story, the refugee(s) travel plans, and any other news that you have to share. Please don't hesitate to be in touch with us at refugeessp@uottawa.ca."
    else
      "Congratulations! We understand that this sponsorship application has been accepted and the refugees will be coming to Canada soon.
       Don't forget to refer your clients to the organizations in your area who can help with the settlement process (beyond SSP scope).
       The impact that your assistance as an SSP Pro Bono Lawyer has made cannot be understated.
       Thank you for giving your time and skill to this sponsorship group through the SSP.
       The SSP would love to hear about your experience as an SSP Pro Bono Lawyer and any other news that you have to share.
       We would also love to facilitate another match. Please don't hesitate to be in touch with us at refugeessp@uottawa.ca."
     end
  end

  def accepted_next_step(application)
  end
end
