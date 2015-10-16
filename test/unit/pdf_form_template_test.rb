require 'test_helper'

class PdfFormMappingTest < ActiveSupport::TestCase
  PDF_FIXTURE = './test/fixtures/pdfs/form_1.pdf'

  setup do
    @pdf_app = PdfApplicationForm.new(PDF_FIXTURE)
  end

  test "#generate_liquid_template generates a liquid template string" do
    mapping = PdfFormTemplate.new(@pdf_app)

    template = mapping.generate_liquid_template
    assert template.include? @pdf_app.form_fields.sample[:name]
  end
end
