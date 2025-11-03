class Admin::SwimmerImportService
  attr_reader :file, :competition_id

  def initialize(file, competition_id)
    @file = file
    @competition_id = competition_id
  end

  def call
    import_swimmers_from_excel
  end

  private

  def import_swimmers_from_excel
    spreadsheet = Roo::Spreadsheet.open(file.path)
    sheet = spreadsheet.sheet(0)
    errors = []
    # Pular o cabeçalho (primeira linha)
    (2..sheet.last_row).each do |row|
      row_data = sheet.row(row)

      next if row_data.compact.empty? # Pular linhas vazias

      parsed_data = Admin::SwimmerArrayParser.new(row_data, competition_id).call

      result = Admin::SwimmerImportItemService.new(parsed_data).call

      unless result[:success]
        errors << result[:error]
      end
    end

    puts errors.inspect
  end
end
