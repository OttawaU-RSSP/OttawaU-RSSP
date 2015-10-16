class PdfFormTemplate
  attr_reader :application_form

  def initialize(application_form)
    @application_form = application_form
  end

  def generate_liquid_template
    hash = application_form.form_fields.inject({}) do |acc, field|
      acc[field[:name]] = { options: field[:options], type: field[:type], value: "" }
      acc
    end
    JSON.pretty_generate(hash)
  end
end
