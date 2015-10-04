class MessageGenerator
  def initialize(warnings)
    @warnings = warnings
  end

  def generate
    messages = []
    @warnings.each do |warning|
      case warning
      when /発表されていません。/
      when /波浪注意報/
        messages << '海の波が高いですね。'
      when /霧注意報/
        messages << '濃い霧が出ていますね。'
      when /雷注意報/
        messages << '近くで雷が鳴っていますね。'
      when /大雨注意報/
        messages << '強い雨が降っていますね。'
      when /強風注意報/
        messages << '強い風がふいていますね。'
      when /大雪注意報/
        messages << '強く雪が降っていますね。'
      end
    end

    if messages.empty?
      messages << '穏やかな日ですね。'
    end
    messages.uniq.join('')
  end
end

