class MessageGenerator
  def initialize(warnings)
    @warnings = warnings
  end

  def generate
    messages = []
    warning = false
    @warnings.each do |w|
      case w
      when /発表されていません。/
      when /波浪/
        messages << '海の波が高いですね。'
      when /濃霧/
        messages << '濃い霧が出ていますね。'
      when /雷/
        messages << '近くで雷が鳴っていますね。'
      when /大雨/
        messages << '強い雨が降っていますね。'
      when /強風/
        messages << '強い風がふいていますね。'
      when /大雪/
        messages << '強く雪が降っていますね。'
      when /洪水/
        messages << '洪水するかもしれません。'
      end
      warning = true if /注意/.match(w)
    end

    if messages.empty?
      messages << '穏やかな日ですね。'
    end
    messages << '警報が出てるので電話してみましょう' if warning
    messages.uniq.join('')
  end
end
