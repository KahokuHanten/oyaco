class PrefName

  def self.get_pref_name(pref_id)
    pref = JpPrefecture::Prefecture.find pref_id
    pref.name
  end
end
