namespace :pdf do
  desc 'Generate liquid templates from all pdfs in vendor/goc/base_pdfs, save in vendor/goc/liquid_templates'
  task :liquid_generate do
    Dir.glob('vendor/goc/base_pdfs/*.pdf') do |pdf|
      pdf_app = PdfApplicationForm.new(pdf)
      pdf = File.basename(pdf).gsub('.pdf', '.json.liquid')
      form_template = PdfFormTemplate.new(pdf_app)
      File.open("vendor/goc/liquid_templates/#{pdf}", 'w') do |file|
        file.write(form_template.generate_liquid_template)
      end
    end
  end
end
