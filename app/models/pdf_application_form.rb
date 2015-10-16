class PdfApplicationForm
  class UnknownAttribute < StandardError; end

  attr_reader :pdf_file, :pdftk

  def initialize(pdf_file, pdftk: OttawaURssp::Application.config.pdftk)
    @pdf_file = pdf_file
    @pdftk = pdftk
  end

  def form_fields
    @form_fields ||= pdftk.get_fields(pdf_file).inject([]) do |fields, current_field|
      fields << {
        type: current_field.type.to_s.downcase,
        name: current_field.name,
        options: current_field.options,
        value: current_field.value
      } unless current_field.type.nil?
      fields
    end
  end

  def fill_form(filled_form_path, attributes)
    validate_attributes(attributes)
    pdftk.fill_form(pdf_file, filled_form_path, attributes)
  end

  protected

  def field_names
    @field_names ||= form_fields.map { |field| field[:name] }
  end

  def validate_attributes(attributes)
    attributes.each do |field, value|
      raise UnknownAttribute, "#{field} is not a valid form field in #{pdf_file}" unless field_names.include? field
    end
  end

end
