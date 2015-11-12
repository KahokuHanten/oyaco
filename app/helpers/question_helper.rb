module QuestionHelper
  def selected_birthday(key)
    cookies.signed[key] ? Date.parse(cookies.signed[key]) :
      Oyaco::Application.config.default_birthday
  end
end
