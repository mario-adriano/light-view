class AnalysesController < ApplicationController
  def upload
  end

  def process_file
    uploaded_file = params[:file]

    if uploaded_file.blank?
      flash.now[:alert] = "Por favor, envie um arquivo para análise."
      render turbo_stream: turbo_stream.append("result", partial: "analyses/error", locals: { error: "Nenhum arquivo enviado." })
      return
    end

    begin
      excel = Roo::Excelx.new(uploaded_file.tempfile.path)
      headers = excel.row(1).map(&:to_s).map(&:strip)

      year_indexes = headers.each_index.select { |i| headers[i].match?(/^\d{4}$/) }
      raise "Colunas de ano não encontradas. Verifique os cabeçalhos." if year_indexes.empty?

      category_index = headers.find_index { |header| header.downcase.include?("ativo") || header.downcase.include?("balanço") }
      category_index ||= 0

      data = []
      (2..excel.last_row).each do |i|
        row = excel.row(i)
        next if row[category_index].nil?

        row_data = { "categoria" => row[category_index].to_s.strip }
        year_indexes.each do |year_idx|
          year = headers[year_idx]
          value = row[year_idx]
          row_data[year.to_i] = value.to_f if value.present? && value.is_a?(Numeric)
        end

        data << row_data unless row_data.empty?
      end

      raise "Nenhum dado relevante encontrado no arquivo." if data.empty?

      all_values = data.flat_map { |d| d.values_at(*year_indexes.map { |idx| headers[idx].to_i }) }.compact
      analysis = {
        total: all_values.sum,
        average: (all_values.sum / all_values.size).round(2),
        max: all_values.max,
        min: all_values.min,
        count: all_values.size
      }

      chart_data = year_indexes.map { |idx| [ headers[idx].to_i, data.sum { |d| d[headers[idx].to_i].to_f } ] }.to_h

      ativo_vs_passivo = {
        ativo: year_indexes.map do |idx|
          data.sum do |d|
            if d["categoria"]&.downcase&.include?("ativo total")
              d[headers[idx].to_i].to_f rescue 0.0
            else
              0.0
            end
          end
        end,
        passivo: year_indexes.map do |idx|
          data.sum do |d|
            if d["categoria"]&.downcase&.include?("passivo total")
              d[headers[idx].to_i].to_f rescue 0.0
            else
              0.0
            end
          end
        end
      }

      receita_vs_custo = {
        receita: year_indexes.map do |idx|
          data.sum do |d|
            if d["categoria"]&.downcase&.include?("receita de vendas")
              d[headers[idx].to_i].to_f rescue 0.0
            else
              0.0
            end
          end
        end,
        custo: year_indexes.map do |idx|
          data.sum do |d|
            if d["categoria"]&.downcase&.include?("custo dos bens e serviços vendidos")
              d[headers[idx].to_i].to_f rescue 0.0
            else
              0.0
            end
          end
        end
      }

      @headers = headers
      @data = data
      @analysis = analysis
      @chart_data = chart_data
      @ativo_vs_passivo = ativo_vs_passivo
      @receita_vs_custo = receita_vs_custo

      render turbo_stream: turbo_stream.replace("result", partial: "analyses/result", locals: { analysis: @analysis, data: @data, chart_data: @chart_data, ativo_vs_passivo: @ativo_vs_passivo, receita_vs_custo: @receita_vs_custo })
    rescue => e
      flash.now[:alert] = "Erro ao processar o arquivo: #{e.message}"
      render turbo_stream: turbo_stream.replace("result", partial: "analyses/error", locals: { error: e.message })
    end
  end
end
