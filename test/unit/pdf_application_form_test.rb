require 'test_helper'

class PdfApplicationFormTest < ActiveSupport::TestCase
  PDF_FIXTURE = './test/fixtures/pdfs/form_1.pdf'

  test "it can get the fields as a hash" do
    pdf_app = PdfApplicationForm.new(PDF_FIXTURE)

    assert_equal "button", pdf_app.form_fields.first[:type]
    assert_equal %w(0 1 2 3 Off), pdf_app.form_fields.first[:options]
  end

  test "#fill_form can fill out a form" do
    pdf_app = PdfApplicationForm.new(PDF_FIXTURE)
    fields = pdf_app.form_fields

    attrs = {
      pdf_app.form_fields.first[:name] => 1
    }

    Tempfile.create('temp_form') do |f|
      pdf_app.fill_form(f.path, attrs)

      filled_form = PdfApplicationForm.new(f.path)
      assert_equal '1', filled_form.form_fields.first[:value]
    end
  end

  test "#fill_form raises a UnknownAttribute error when an invalid field name passed in" do
    pdf_app = PdfApplicationForm.new(PDF_FIXTURE)

    assert_raises PdfApplicationForm::UnknownAttribute do
      Tempfile.create('temp_form') do |f|
        pdf_app.fill_form(f.path, { "uknown_field" => "foobar" })
      end
    end
  end
end
